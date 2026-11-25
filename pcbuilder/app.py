from flask import Flask, render_template, request, Response, session
import pymysql
import time

app = Flask(__name__)
app.secret_key = 'pc_builder_z8_secret_key'

DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'root',
    'password': '',
    'database': 'pckonfig',
    'cursorclass': pymysql.cursors.DictCursor
}

def get_db_connection():
    return pymysql.connect(**DB_CONFIG)

def count_cartesian_combinations(cursor):
    """Liczy teoretyczną liczbę kombinacji dla zwykłego filtra kaskadowego"""
    tables = ['procesory', 'karty_graficzne', 'plyty_glowne', 'pamiec_ram', 'power_supplies']
    total_combos = 1
    for t in tables:
        cursor.execute(f"SELECT COUNT(*) as cnt FROM {t}")
        total_combos *= cursor.fetchone()['cnt']
    return total_combos

def run_rule_engine(budget, cel, cpu_pref, gpu_pref, future_proof):
    start_time = time.perf_counter()
    conn = get_db_connection()
    cursor = conn.cursor()

    total_combinations = count_cartesian_combinations(cursor)
    logs = []
    rules_fired = 0

    logs.append(f"START: Budżet {budget} PLN | Cel: {cel.upper()} | Future-proof: {'TAK' if future_proof else 'NIE'}.")

    #r1: podział budżetu
    rules_fired += 1
    if cel == 'gaming':
        shares = {'gpu': 0.40, 'cpu': 0.20, 'mobo': 0.12, 'ram': 0.09, 'dysk': 0.06, 'case': 0.05, 'psu': 0.08}
    elif cel == 'workstation':
        shares = {'gpu': 0.28, 'cpu': 0.32, 'mobo': 0.13, 'ram': 0.10, 'dysk': 0.06, 'case': 0.04, 'psu': 0.07}
    else:  # office
        shares = {'gpu': 0.00, 'cpu': 0.38, 'mobo': 0.18, 'ram': 0.14, 'dysk': 0.12, 'case': 0.08, 'psu': 0.10}

    gpu_budget = budget * shares['gpu']
    cpu_budget = budget * shares['cpu']
    logs.append(f"Reguła 1 (Alokacja 100%): GPU={round(gpu_budget)} PLN, CPU={round(cpu_budget)} PLN, reszta podzespołów={round(budget - gpu_budget - cpu_budget)} PLN.")

    #r2: GPU
    gpu_candidates = [None]
    if cel in ['gaming', 'workstation']:
        rules_fired += 1
        gpu_query = "SELECT * FROM karty_graficzne WHERE cena_rynkowa_pln <= %s"
        gpu_params = [gpu_budget]

        if gpu_pref != 'any':
            gpu_query += " AND producent = %s"
            gpu_params.append(gpu_pref)

        gpu_query += " ORDER BY (pamiec_vram_gb * 100 + rdzenie_gpu) DESC LIMIT 4"
        cursor.execute(gpu_query, gpu_params)
        fetched_gpus = cursor.fetchall()
        if fetched_gpus:
            gpu_candidates = fetched_gpus

    #r3-4:CPU,anti-bottleneck
    rules_fired += 1
    seen_builds = session.get('seen_builds', [])
    search_prefix = f"{cel}|{budget}|{cpu_pref}|{gpu_pref}|{future_proof}|"
    matching_seen = [s for s in seen_builds if s.startswith(search_prefix)]

    valid_pairs = []
    for g in gpu_candidates:
        g_cost = float(g['cena_rynkowa_pln']) if g else 0.0
        g_saved = max(0.0, gpu_budget - g_cost)
        max_cpu_price = cpu_budget + g_saved

        cpu_query = "SELECT * FROM procesory WHERE cena_pln <= %s"
        cpu_params = [max_cpu_price]

        if cel == 'office':
            cpu_query += " AND zintegrowana_grafika = 1"
        if cpu_pref != 'any':
            cpu_query += " AND producent = %s"
            cpu_params.append(cpu_pref)
        if future_proof:
            cpu_query += " AND pamiec_ram LIKE '%%DDR5%%'"
        if g and g['segment_rynku'] in ['wysoki', 'entuzjasta']:
            cpu_query += " AND rdzenie >= 6"

        cpu_query += " ORDER BY (rdzenie * taktowanie_boost_ghz * 10 + cache_l3_mb) DESC LIMIT 4"
        cursor.execute(cpu_query, cpu_params)
        for c in cursor.fetchall():
            pair_id = f"{search_prefix}{c['model']}|{g['model'] if g else 'IGPU'}"
            valid_pairs.append((g, c, pair_id))

    gpu = None
    cpu = None
    variant_index = len(matching_seen)

    if valid_pairs:
        unseen_pairs = [p for p in valid_pairs if p[2] not in seen_builds]
        if unseen_pairs:
            gpu, cpu, chosen_id = unseen_pairs[0]
            if variant_index > 0:
                rules_fired += 1
                logs.append(f"Reguła 2 (Wariantowość): Pominięto poprzednie zestawy ({variant_index}), dobrano kolejną optymalną parę CPU+GPU.")
        else:
            seen_builds = [s for s in seen_builds if not s.startswith(search_prefix)]
            gpu, cpu, chosen_id = valid_pairs[0]
            variant_index = 0
            logs.append("Reguła 2 (Wariantowość): Wyświetlono wszystkie unikalne warianty dla tego budżetu — cykl rozpoczyna się od nowa.")

        seen_builds.append(chosen_id)
        session['seen_builds'] = seen_builds[-30:]

    if gpu:
        logs.append(f"Reguła 3 (GPU): {gpu['producent']} {gpu['model']} ({gpu['cena_rynkowa_pln']} PLN, VRAM: {gpu['pamiec_vram_gb']}GB).")
    if cpu:
        if gpu and gpu['segment_rynku'] in ['wysoki', 'entuzjasta']:
            rules_fired += 1
            logs.append(f"Reguła 4a (Anti-Bottleneck): Mocne GPU ({gpu['segment_rynku']}) -> wymuszono CPU min. 6 rdzeni.")
        logs.append(f"Reguła 4b (CPU): {cpu['producent']} {cpu['model']} ({cpu['cena_pln']} PLN, TDP: {cpu['tdp_w']}W).")

    spent_total = (float(gpu['cena_rynkowa_pln']) if gpu else 0.0) + (float(cpu['cena_pln']) if cpu else 0.0)
    remaining = budget - spent_total

    MIN_MOBO, MIN_RAM, MIN_DYSK, MIN_CASE, MIN_PSU = 220.0, 100.0, 100.0, 100.0, 150.0
    min_downstream = MIN_MOBO + MIN_RAM + MIN_DYSK + MIN_CASE + MIN_PSU

    #r5: Chłodzenie CPU
    cooler_reserved = 0.0
    if cpu and cpu['tdp_w'] > 65:
        rules_fired += 1
        desired_cooler = 150.0 if cpu['tdp_w'] <= 105 else 300.0
        saved_on_core = max(0.0, (gpu_budget + cpu_budget) - spent_total)
        if saved_on_core >= desired_cooler and (remaining - desired_cooler) >= min_downstream:
            cooler_reserved = desired_cooler
        elif saved_on_core >= 100.0 and (remaining - 100.0) >= min_downstream:
            cooler_reserved = 100.0

        if cooler_reserved > 0:
            spent_total += cooler_reserved
            remaining = budget - spent_total
            logs.append(f"Reguła 5 (Chłodzenie): TDP {cpu['tdp_w']}W -> zarezerwowano {cooler_reserved} PLN z zaoszczędzonej puli.")

    #r6: Płyta główna
    mobo = None
    if cpu:
        rules_fired += 1
        rem_weight = shares['mobo'] + shares['ram'] + shares['dysk'] + shares['case'] + shares['psu']
        mobo_target = remaining * (shares['mobo'] / rem_weight)
        mobo_cap = min(mobo_target * 1.15, remaining - (MIN_RAM + MIN_DYSK + MIN_CASE + MIN_PSU))

        mobo_query = """
            SELECT * FROM plyty_glowne 
            WHERE socket = %s 
              AND %s LIKE CONCAT('%%', typ_pamieci, '%%') 
              AND cena_pln <= %s
        """
        mobo_params = [cpu['socket'], cpu['pamiec_ram'], max(0.0, mobo_cap)]
        if future_proof:
            mobo_query += " AND typ_pamieci = 'DDR5'"
        mobo_query += " ORDER BY cena_pln DESC LIMIT 3"

        cursor.execute(mobo_query, mobo_params)
        mobo_list = cursor.fetchall()
        if mobo_list:
            mobo = mobo_list[variant_index % len(mobo_list)]
            spent_total += float(mobo['cena_pln'])
            remaining = budget - spent_total
            logs.append(f"Reguła 6 (MOBO): {mobo['producent']} {mobo['model']} ({mobo['socket']}, {mobo['typ_pamieci']}) za {mobo['cena_pln']} PLN.")

    #r7: RAM
    ram = None
    if mobo:
        rules_fired += 1
        rem_weight = shares['ram'] + shares['dysk'] + shares['case'] + shares['psu']
        ram_target = remaining * (shares['ram'] / rem_weight)
        ram_cap = min(ram_target * 1.15, remaining - (MIN_DYSK + MIN_CASE + MIN_PSU))

        cursor.execute("""
            SELECT * FROM pamiec_ram 
            WHERE typ_pamieci = %s AND cena_rynkowa_pln_od <= %s 
            ORDER BY pojemnosc_calkowita_gb DESC, taktowanie_mhz DESC LIMIT 3
        """, (mobo['typ_pamieci'], max(0.0, ram_cap)))
        ram_list = cursor.fetchall()
        if ram_list:
            ram = ram_list[variant_index % len(ram_list)]
            spent_total += float(ram['cena_rynkowa_pln_od'])
            remaining = budget - spent_total
            logs.append(f"Reguła 7 (RAM): {ram['producent']} {ram['model']} ({ram['pojemnosc_calkowita_gb']}GB {ram['typ_pamieci']}) za {ram['cena_rynkowa_pln_od']} PLN.")

    #r8: SSD
    rules_fired += 1
    dysk = None
    rem_weight = shares['dysk'] + shares['case'] + shares['psu']
    dysk_target = remaining * (shares['dysk'] / rem_weight)
    dysk_cap = min(dysk_target * 1.25, remaining - (MIN_CASE + MIN_PSU))

    if cel in ['gaming', 'workstation']:
        cursor.execute("""
            SELECT * FROM dyski 
            WHERE cena_pln <= %s AND interfejs = 'NVMe' 
            ORDER BY pojemnosc_gb DESC, predkosc_odczytu_mbs DESC LIMIT 3
        """, (max(0.0, dysk_cap),))
    else:
        cursor.execute("SELECT * FROM dyski WHERE cena_pln <= %s ORDER BY pojemnosc_gb DESC LIMIT 3", (max(0.0, dysk_cap),))
    dysk_list = cursor.fetchall()
    if dysk_list:
        dysk = dysk_list[variant_index % len(dysk_list)]
        spent_total += float(dysk['cena_pln'])
        remaining = budget - spent_total
        logs.append(f"Reguła 8 (Dysk): {dysk['producent']} {dysk['model']} {dysk['pojemnosc_gb']}GB ({dysk['interfejs']}) za {dysk['cena_pln']} PLN.")

    #r9: Obudowa
    case = None
    if mobo:
        rules_fired += 1
        rem_weight = shares['case'] + shares['psu']
        case_target = remaining * (shares['case'] / rem_weight)
        case_cap = min(case_target * 1.25, remaining - MIN_PSU)

        fmt = mobo['format'].lower()
        if fmt == 'e-atx':
            allowed_formats = ('E-ATX',)
        elif fmt == 'atx':
            allowed_formats = ('ATX', 'E-ATX')
        elif fmt == 'micro-atx':
            allowed_formats = ('Micro-ATX', 'ATX', 'E-ATX')
        else:
            allowed_formats = ('Mini-ITX', 'Micro-ATX', 'ATX', 'E-ATX')

        placeholders = ', '.join(['%s'] * len(allowed_formats))
        cursor.execute(f"""
            SELECT * FROM pc_cases 
            WHERE form_factor IN ({placeholders}) AND price_pln <= %s 
            ORDER BY price_pln DESC LIMIT 3
        """, (*allowed_formats, max(0.0, case_cap)))
        case_list = cursor.fetchall()
        if case_list:
            case = case_list[variant_index % len(case_list)]
            spent_total += float(case['price_pln'])
            remaining = budget - spent_total
            logs.append(f"Reguła 9 (Obudowa): {case['brand']} {case['model']} ({case['form_factor']}) za {case['price_pln']} PLN.")

    #r: Zasilacz
    psu = None
    if cpu and mobo and ram:
        rules_fired += 1
        gpu_power = gpu['tdp_w'] if gpu else 0
        sys_power = gpu_power + cpu['tdp_w'] + 80
        min_psu = sys_power * 1.25
        max_psu = sys_power * 1.65
        psu_cap = max(0.0, remaining)

        needs_12v = gpu and ('12V' in gpu['zlacze_zasilania'])
        if needs_12v:
            cursor.execute("""
                SELECT * FROM power_supplies 
                WHERE wattage_w >= %s AND wattage_w <= %s AND native_12v_2x6 = 1 AND price_pln <= %s 
                ORDER BY price_pln ASC LIMIT 1
            """, (min_psu, max_psu, psu_cap))
            psu = cursor.fetchone()

        if not psu:
            cursor.execute("""
                SELECT * FROM power_supplies 
                WHERE wattage_w >= %s AND wattage_w <= %s AND price_pln <= %s 
                ORDER BY price_pln ASC LIMIT 1
            """, (min_psu, max_psu, psu_cap))
            psu = cursor.fetchone()

        if not psu:
            cursor.execute("""
                SELECT * FROM power_supplies 
                WHERE wattage_w >= %s AND price_pln <= %s 
                ORDER BY price_pln ASC LIMIT 1
            """, (min_psu, psu_cap))
            psu = cursor.fetchone()

        if psu:
            spent_total += float(psu['price_pln'])
            remaining = budget - spent_total
            złącze_info = " (natywne 12V-2x6)" if psu['native_12v_2x6'] else ""
            logs.append(f"Reguła 10 (Zasilacz): TDP {sys_power}W -> dobrano {psu['wattage_w']}W{złącze_info} za {psu['price_pln']} PLN.")

    #r11: >150 +
    if dysk and remaining >= 150.0:
        upgrade_cap = float(dysk['cena_pln']) + remaining
        cursor.execute("""
            SELECT * FROM dyski 
            WHERE cena_pln <= %s AND pojemnosc_gb > %s 
            ORDER BY pojemnosc_gb DESC, predkosc_odczytu_mbs DESC LIMIT 1
        """, (upgrade_cap, dysk['pojemnosc_gb']))
        better_dysk = cursor.fetchone()
        if better_dysk:
            rules_fired += 1
            spent_total = spent_total - float(dysk['cena_pln']) + float(better_dysk['cena_pln'])
            remaining = budget - spent_total
            dysk = better_dysk
            logs.append(f"Reguła 11 (Optymalizacja reszty): Wolne środki przeznaczono na większy SSD {dysk['pojemnosc_gb']}GB (nadal w budżecie!).")

    conn.close()
    exec_time = round(time.perf_counter() - start_time, 4)

    if cpu and mobo and ram and psu:
        return {
            'cpu': cpu, 'gpu': gpu, 'mobo': mobo, 'ram': ram,
            'dysk': dysk, 'case': case, 'psu': psu,
            'cooler_reserved': cooler_reserved,
            'total_price': round(spent_total, 2),
            'budget_left': round(remaining, 2),
            'budget': budget,
            'cel': cel,
            'logs': logs,
            'exec_time': exec_time,
            'rules_fired': rules_fired,
            'total_combinations': f"{total_combinations:,}".replace(",", " ")
        }
    else:
        return {
            'error': 'Nie udało się złożyć pełnego zestawu w tym budżecie (zbyt niska kwota dla wybranych wymagań).',
            'logs': logs,
            'exec_time': exec_time,
            'rules_fired': rules_fired,
            'total_combinations': f"{total_combinations:,}".replace(",", " ")
        }

@app.route('/', methods=['GET'])
def index():
    return render_template('index.html', result=None)

@app.route('/recommend', methods=['POST'])
def recommend():
    budget = float(request.form['budget'])
    cel = request.form['cel']
    cpu_pref = request.form['cpu_pref']
    gpu_pref = request.form['gpu_pref']
    future_proof = 'future_proof' in request.form

    result = run_rule_engine(budget, cel, cpu_pref, gpu_pref, future_proof)
    return render_template('index.html', result=result)

@app.route('/export', methods=['POST'])
def export_txt():
    content = request.form.get('export_text', '')
    return Response(
        content,
        mimetype="text/plain",
        headers={"Content-Disposition": "attachment;filename=konfiguracja_pc.txt"}
    )

if __name__ == '__main__':
    app.run(debug=True)