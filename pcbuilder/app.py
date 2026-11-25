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
    tables = ['procesory', 'karty_graficzne', 'plyty_glowne', 'pamiec_ram', 'power_supplies']
    total_combos = 1
    for t in tables:
        cursor.execute(f"SELECT COUNT(*) as cnt FROM {t}")
        total_combos *= cursor.fetchone()['cnt']
    return total_combos


def get_gpu_target_classes(budget, cel, future_proof):
    if cel == 'gaming':
        if budget < 4600:
            return ['C_budzetowy', 'B_sredni'], ['aktualny']
        elif budget <= 7000:
            return ['B_sredni'], ['aktualny']
        elif budget <= 10500:
            gens = ['aktualny'] if future_proof else ['aktualny', 'poprzednia_gen']
            return ['A_wysoki'], gens
        else:
            gens = ['aktualny'] if future_proof else ['aktualny', 'poprzednia_gen']
            return ['S_flagowiec', 'A_wysoki'], gens

    gens = ['aktualny'] if future_proof else ['aktualny', 'poprzednia_gen']
    if budget < 5500:
        return ['C_budzetowy', 'B_sredni'], ['aktualny']
    elif budget <= 9500:
        return ['B_sredni', 'A_wysoki'], gens
    else:
        return ['A_wysoki', 'S_flagowiec'], gens


def interleave_gpu_cpu_pairs(grouped_pairs):
    mixed = []
    max_len = max((len(group) for group in grouped_pairs), default=0)
    for i in range(max_len):
        for group in grouped_pairs:
            if i < len(group):
                mixed.append(group[i])
    return mixed


def run_rule_engine(budget, cel, cpu_pref, gpu_pref, future_proof):
    start_time = time.perf_counter()
    conn = get_db_connection()
    cursor = conn.cursor()

    total_combinations = count_cartesian_combinations(cursor)
    logs = []
    rules_fired = 0

    logs.append(f"START: Budżet {budget} PLN | Cel: {cel.upper()} | Future-proof: {'TAK' if future_proof else 'NIE'}.")

    rules_fired += 1
    if cel == 'gaming':
        shares = {'gpu': 0.36, 'cpu': 0.18, 'mobo': 0.10, 'ram': 0.19, 'dysk': 0.06, 'case': 0.04, 'psu': 0.07}
    elif cel == 'workstation':
        shares = {'gpu': 0.24, 'cpu': 0.28, 'mobo': 0.11, 'ram': 0.21, 'dysk': 0.06, 'case': 0.04, 'psu': 0.06}
    else:
        shares = {'gpu': 0.00, 'cpu': 0.32, 'mobo': 0.16, 'ram': 0.24, 'dysk': 0.11, 'case': 0.08, 'psu': 0.09}

    gpu_budget = budget * shares['gpu']
    cpu_budget = budget * shares['cpu']
    logs.append(
        f"Reguła 1 (Alokacja 100%): GPU={round(gpu_budget)} PLN, CPU={round(cpu_budget)} PLN, "
        f"reszta podzespołów={round(budget - gpu_budget - cpu_budget)} PLN."
    )

    gpu_candidates = [None]
    if cel in ['gaming', 'workstation']:
        rules_fired += 1
        target_tiers, target_gens = get_gpu_target_classes(budget, cel, future_proof)
        placeholders = ', '.join(['%s'] * len(target_tiers))

        base_sql = (
            f"SELECT * FROM karty_graficzne WHERE cena_rynkowa_pln <= %s "
            f"AND klasa_wydajnosci IN ({placeholders}) AND status_generacji = %s"
        )
        base_params = [gpu_budget, *target_tiers, 'aktualny']
        if gpu_pref != 'any':
            base_sql += " AND producent = %s"
            base_params.append(gpu_pref)
        base_sql += " ORDER BY ocena_wydajnosci DESC, cena_rynkowa_pln DESC LIMIT 6"

        cursor.execute(base_sql, base_params)
        curr_gpus = cursor.fetchall()

        prev_gpus = []
        if 'poprzednia_gen' in target_gens:
            prev_sql = (
                f"SELECT * FROM karty_graficzne WHERE cena_rynkowa_pln <= %s "
                f"AND klasa_wydajnosci IN ({placeholders}) AND status_generacji = 'poprzednia_gen'"
            )
            prev_params = [gpu_budget, *target_tiers]
            if gpu_pref != 'any':
                prev_sql += " AND producent = %s"
                prev_params.append(gpu_pref)
            prev_sql += " ORDER BY ocena_wydajnosci DESC, cena_rynkowa_pln DESC LIMIT 3"

            cursor.execute(prev_sql, prev_params)
            prev_gpus = cursor.fetchall()

        fetched_gpus = []
        if prev_gpus:
            for idx in range(max(len(curr_gpus[:5]), len(prev_gpus))):
                if idx < len(curr_gpus[:5]):
                    fetched_gpus.append(curr_gpus[idx])
                if idx < len(prev_gpus):
                    fetched_gpus.append(prev_gpus[idx])
        else:
            fetched_gpus = curr_gpus

        if not fetched_gpus:
            fb_sql = "SELECT * FROM karty_graficzne WHERE cena_rynkowa_pln <= %s AND status_generacji != 'archiwum'"
            fb_params = [gpu_budget]
            if gpu_pref != 'any':
                fb_sql += " AND producent = %s"
                fb_params.append(gpu_pref)
            fb_sql += " ORDER BY ocena_wydajnosci DESC, cena_rynkowa_pln DESC LIMIT 6"
            cursor.execute(fb_sql, fb_params)
            fetched_gpus = cursor.fetchall()

        if fetched_gpus:
            gpu_candidates = fetched_gpus

    rules_fired += 1
    seen_builds = session.get('seen_builds', [])
    search_prefix = f"{cel}|{budget}|{cpu_pref}|{gpu_pref}|{future_proof}|"
    matching_seen = [s for s in seen_builds if s.startswith(search_prefix)]

    prefer_ddr4_platform = (not future_proof) and (
        (cel == 'office' and budget < 3500) or (cel in ['gaming', 'workstation'] and budget < 6500)
    )

    grouped_pairs = []
    for g in gpu_candidates:
        g_cost = float(g['cena_rynkowa_pln']) if g else 0.0
        g_saved = max(0.0, gpu_budget - g_cost)
        max_cpu_price = cpu_budget + (g_saved * 0.70)

        cpu_query = "SELECT * FROM procesory WHERE cena_pln <= %s AND status_generacji != 'archiwum'"
        cpu_params = [max_cpu_price]

        if cel == 'office':
            cpu_query += " AND zintegrowana_grafika = 1"
        if cpu_pref != 'any':
            cpu_query += " AND producent = %s"
            cpu_params.append(cpu_pref)
        if future_proof:
            cpu_query += " AND status_generacji = 'aktualny' AND pamiec_ram LIKE '%%DDR5%%'"

        if g:
            g_tier = g['klasa_wydajnosci']
            if g_tier == 'S_flagowiec':
                cpu_query += " AND klasa_wydajnosci IN ('S_flagowiec', 'A_wysoki')"
            elif g_tier == 'A_wysoki':
                cpu_query += " AND klasa_wydajnosci IN ('S_flagowiec', 'A_wysoki', 'B_sredni') AND ocena_wydajnosci >= 58"
            elif g_tier == 'B_sredni':
                cpu_query += " AND klasa_wydajnosci IN ('A_wysoki', 'B_sredni', 'C_budzetowy') AND rdzenie >= 6"

        if prefer_ddr4_platform:
            cpu_query += (
                " ORDER BY CASE WHEN pamiec_ram LIKE '%%DDR4%%' THEN 0 ELSE 1 END ASC, "
                "ocena_wydajnosci DESC, cena_pln DESC LIMIT 3"
            )
        else:
            cpu_query += (
                " ORDER BY FIELD(status_generacji, 'aktualny', 'poprzednia_gen') ASC, "
                "ocena_wydajnosci DESC, cena_pln DESC LIMIT 3"
            )
        cursor.execute(cpu_query, cpu_params)

        per_gpu = []
        for c in cursor.fetchall():
            pair_id = f"{search_prefix}{c['model']}|{g['model'] if g else 'IGPU'}"
            per_gpu.append((g, c, pair_id))
        if per_gpu:
            grouped_pairs.append(per_gpu)

    valid_pairs = interleave_gpu_cpu_pairs(grouped_pairs)

    gpu = None
    cpu = None
    variant_index = len(matching_seen)

    if valid_pairs:
        unseen_pairs = [p for p in valid_pairs if p[2] not in seen_builds]
        if unseen_pairs:
            gpu, cpu, chosen_id = unseen_pairs[0]
            if variant_index > 0:
                rules_fired += 1
                logs.append(f"Reguła 2 (Wariantowość): Pominięto poprzednie zestawy ({variant_index}), dobrano kolejną parę CPU+GPU.")
        else:
            seen_builds = [s for s in seen_builds if not s.startswith(search_prefix)]
            gpu, cpu, chosen_id = valid_pairs[0]
            variant_index = 0
            logs.append("Reguła 2 (Wariantowość): Wyświetlono wszystkie unikalne warianty dla tego budżetu — cykl rozpoczyna się od nowa.")

        seen_builds.append(chosen_id)
        session['seen_builds'] = seen_builds[-30:]

    if gpu:
        logs.append(
            f"Reguła 3 (GPU): {gpu['producent']} {gpu['model']} "
            f"[{gpu['klasa_wydajnosci']}, {gpu['status_generacji']}, ocena {gpu['ocena_wydajnosci']}/100] "
            f"za {gpu['cena_rynkowa_pln']} PLN."
        )
    if cpu:
        if gpu and gpu['klasa_wydajnosci'] in ['A_wysoki', 'S_flagowiec']:
            rules_fired += 1
            logs.append(f"Reguła 4a (Anti-Bottleneck): Karta klasy {gpu['klasa_wydajnosci']} -> dopasowano procesor min. klasy B/A.")
        logs.append(
            f"Reguła 4b (CPU): {cpu['producent']} {cpu['model']} "
            f"[{cpu['klasa_wydajnosci']}, {cpu['status_generacji']}] za {cpu['cena_pln']} PLN."
        )

    spent_total = (float(gpu['cena_rynkowa_pln']) if gpu else 0.0) + (float(cpu['cena_pln']) if cpu else 0.0)
    remaining = budget - spent_total

    MIN_MOBO = 280.0
    MIN_RAM_DDR4 = 600.0
    MIN_RAM_DDR5 = 1150.0
    MIN_RAM = MIN_RAM_DDR5 if future_proof else MIN_RAM_DDR4
    MIN_DYSK = 240.0 if cel in ['gaming', 'workstation'] else 120.0
    MIN_CASE = 180.0
    MIN_PSU = 190.0
    min_downstream = MIN_MOBO + MIN_RAM + MIN_DYSK + MIN_CASE + MIN_PSU

    cooler_reserved = 0.0
    if cpu and cpu['tdp_w'] > 65:
        rules_fired += 1
        desired_cooler = 150.0 if cpu['tdp_w'] <= 105 else 280.0
        saved_on_core = max(0.0, (gpu_budget + cpu_budget) - spent_total)
        if saved_on_core >= desired_cooler and (remaining - desired_cooler) >= min_downstream:
            cooler_reserved = desired_cooler
        elif saved_on_core >= 100.0 and (remaining - 100.0) >= min_downstream:
            cooler_reserved = 100.0

        if cooler_reserved > 0:
            spent_total += cooler_reserved
            remaining = budget - spent_total
            logs.append(f"Reguła 5 (Chłodzenie): TDP {cpu['tdp_w']}W -> zarezerwowano {cooler_reserved} PLN z zaoszczędzonej puli.")

    mobo = None
    if cpu:
        rules_fired += 1
        cpu_supports_ddr4 = 'DDR4' in cpu['pamiec_ram']
        effective_min_ram = MIN_RAM_DDR5 if (future_proof or not cpu_supports_ddr4) else MIN_RAM_DDR4
        rem_weight = shares['mobo'] + shares['ram'] + shares['dysk'] + shares['case'] + shares['psu']
        mobo_target = remaining * (shares['mobo'] / rem_weight)
        mobo_cap = min(mobo_target * 1.20, remaining - (effective_min_ram + MIN_DYSK + MIN_CASE + MIN_PSU))

        mobo_query = (
            "SELECT * FROM plyty_glowne WHERE socket = %s "
            "AND %s LIKE CONCAT('%%', typ_pamieci, '%%') "
            "AND status_generacji != 'archiwum' AND cena_pln <= %s"
        )
        mobo_params = [cpu['socket'], cpu['pamiec_ram'], max(0.0, mobo_cap)]
        if future_proof:
            mobo_query += " AND typ_pamieci = 'DDR5' AND status_generacji = 'aktualny'"
        if (remaining - mobo_cap) < 1600.0:
            mobo_query += " AND format != 'E-ATX'"

        if not future_proof and remaining < 3100.0:
            mobo_query += (
                " ORDER BY CASE WHEN typ_pamieci = 'DDR4' THEN 0 ELSE 1 END ASC, "
                "ocena_wydajnosci DESC, cena_pln DESC LIMIT 3"
            )
        else:
            mobo_query += (
                " ORDER BY FIELD(status_generacji, 'aktualny', 'poprzednia_gen') ASC, "
                "ocena_wydajnosci DESC, cena_pln DESC LIMIT 3"
            )
        cursor.execute(mobo_query, mobo_params)
        mobo_list = cursor.fetchall()
        if mobo_list:
            mobo = mobo_list[variant_index % len(mobo_list)]
            spent_total += float(mobo['cena_pln'])
            remaining = budget - spent_total
            logs.append(f"Reguła 6 (MOBO): {mobo['producent']} {mobo['model']} ({mobo['socket']}, {mobo['typ_pamieci']}) za {mobo['cena_pln']} PLN.")

    ram = None
    if mobo:
        rules_fired += 1
        rem_weight = shares['ram'] + shares['dysk'] + shares['case'] + shares['psu']
        ram_target = remaining * (shares['ram'] / rem_weight)
        max_possible_ram = remaining - (MIN_DYSK + MIN_CASE + MIN_PSU)
        ram_cap = min(ram_target * 1.25, max_possible_ram)

        ram_sql = (
            "SELECT * FROM pamiec_ram WHERE typ_pamieci = %s "
            "AND status_generacji != 'archiwum' AND cena_rynkowa_pln_od <= %s "
            "ORDER BY FIELD(status_generacji, 'aktualny', 'poprzednia_gen') ASC, "
            "ocena_wydajnosci DESC, cena_rynkowa_pln_od ASC LIMIT 3"
        )
        cursor.execute(ram_sql, (mobo['typ_pamieci'], max(0.0, ram_cap)))
        ram_list = cursor.fetchall()

        if not ram_list and max_possible_ram > ram_cap:
            fb_ram_sql = (
                "SELECT * FROM pamiec_ram WHERE typ_pamieci = %s "
                "AND status_generacji != 'archiwum' AND cena_rynkowa_pln_od <= %s "
                "ORDER BY cena_rynkowa_pln_od ASC LIMIT 1"
            )
            cursor.execute(fb_ram_sql, (mobo['typ_pamieci'], max(0.0, max_possible_ram)))
            ram_list = cursor.fetchall()

        if ram_list:
            ram = ram_list[variant_index % len(ram_list)]
            spent_total += float(ram['cena_rynkowa_pln_od'])
            remaining = budget - spent_total
            logs.append(f"Reguła 7 (RAM): {ram['producent']} {ram['model']} ({ram['pojemnosc_calkowita_gb']}GB {ram['typ_pamieci']}) za {ram['cena_rynkowa_pln_od']} PLN.")

    rules_fired += 1
    dysk = None
    rem_weight = shares['dysk'] + shares['case'] + shares['psu']
    dysk_target = remaining * (shares['dysk'] / rem_weight)
    dysk_cap = min(dysk_target * 1.25, remaining - (MIN_CASE + MIN_PSU))

    if cel in ['gaming', 'workstation']:
        dysk_sql = (
            "SELECT * FROM dyski WHERE cena_pln <= %s AND interfejs = 'NVMe' "
            "AND status_generacji = 'aktualny' ORDER BY ocena_wydajnosci DESC, pojemnosc_gb DESC, cena_pln ASC LIMIT 3"
        )
        cursor.execute(dysk_sql, (max(0.0, dysk_cap),))
    else:
        dysk_sql = (
            "SELECT * FROM dyski WHERE cena_pln <= %s AND typ_dysku = 'SSD' "
            "ORDER BY ocena_wydajnosci DESC, pojemnosc_gb DESC, cena_pln ASC LIMIT 3"
        )
        cursor.execute(dysk_sql, (max(0.0, dysk_cap),))
    dysk_list = cursor.fetchall()
    if dysk_list:
        dysk = dysk_list[variant_index % len(dysk_list)]
        spent_total += float(dysk['cena_pln'])
        remaining = budget - spent_total
        logs.append(f"Reguła 8 (Dysk): {dysk['producent']} {dysk['model']} {dysk['pojemnosc_gb']}GB ({dysk['interfejs']}) za {dysk['cena_pln']} PLN.")

    case = None
    if mobo:
        rules_fired += 1
        rem_weight = shares['case'] + shares['psu']
        case_target = remaining * (shares['case'] / rem_weight)
        case_cap = min(case_target * 1.30, remaining - MIN_PSU)

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
        case_sql = (
            f"SELECT * FROM pc_cases WHERE form_factor IN ({placeholders}) AND price_pln <= %s "
            "ORDER BY FIELD(generation_status, 'current', 'previous_gen', 'legacy') ASC, "
            "performance_score DESC, price_pln DESC LIMIT 3"
        )
        cursor.execute(case_sql, (*allowed_formats, max(0.0, case_cap)))
        case_list = cursor.fetchall()

        if not case_list:
            fallback_case_sql = (
                f"SELECT * FROM pc_cases WHERE form_factor IN ({placeholders}) AND price_pln <= %s "
                "ORDER BY price_pln ASC LIMIT 1"
            )
            cursor.execute(fallback_case_sql, (*allowed_formats, max(0.0, remaining - MIN_PSU)))
            case_list = cursor.fetchall()

        if case_list:
            case = case_list[variant_index % len(case_list)]
            spent_total += float(case['price_pln'])
            remaining = budget - spent_total
            logs.append(f"Reguła 9 (Obudowa): {case['brand']} {case['model']} ({case['form_factor']}) za {case['price_pln']} PLN.")

    psu = None
    if cpu and mobo and ram:
        rules_fired += 1
        gpu_power = gpu['tdp_w'] if gpu else 0
        sys_power = gpu_power + cpu['tdp_w'] + 80
        min_psu = sys_power * 1.25
        max_psu = sys_power * 1.75
        psu_cap = max(0.0, remaining)

        needs_12v = gpu and ('12V' in gpu['zlacze_zasilania'])
        if needs_12v:
            psu_12v_sql = (
                "SELECT * FROM power_supplies WHERE wattage_w >= %s AND wattage_w <= %s "
                "AND native_12v_2x6 = 1 AND price_pln <= %s "
                "ORDER BY FIELD(generation_status, 'current', 'previous_gen', 'legacy') ASC, "
                "performance_score DESC, price_pln ASC LIMIT 1"
            )
            cursor.execute(psu_12v_sql, (min_psu, max_psu, psu_cap))
            psu = cursor.fetchone()

        if not psu:
            psu_std_sql = (
                "SELECT * FROM power_supplies WHERE wattage_w >= %s AND wattage_w <= %s "
                "AND price_pln <= %s "
                "ORDER BY FIELD(generation_status, 'current', 'previous_gen', 'legacy') ASC, "
                "performance_score DESC, price_pln ASC LIMIT 1"
            )
            cursor.execute(psu_std_sql, (min_psu, max_psu, psu_cap))
            psu = cursor.fetchone()

        if not psu:
            psu_fb_sql = "SELECT * FROM power_supplies WHERE wattage_w >= %s AND price_pln <= %s ORDER BY price_pln ASC LIMIT 1"
            cursor.execute(psu_fb_sql, (min_psu, psu_cap))
            psu = cursor.fetchone()

        if psu:
            spent_total += float(psu['price_pln'])
            remaining = budget - spent_total
            zlacze_info = " (natywne 12V-2x6)" if psu['native_12v_2x6'] else ""
            logs.append(f"Reguła 10 (Zasilacz): TDP {sys_power}W -> dobrano {psu['wattage_w']}W{zlacze_info} za {psu['price_pln']} PLN.")

    if ram and psu and ram['pojemnosc_calkowita_gb'] < 32 and remaining >= 500.0:
        ram_up_cap = float(ram['cena_rynkowa_pln_od']) + remaining
        ram_up_sql = (
            "SELECT * FROM pamiec_ram WHERE typ_pamieci = %s "
            "AND pojemnosc_calkowita_gb >= 32 AND status_generacji != 'archiwum' "
            "AND cena_rynkowa_pln_od <= %s "
            "ORDER BY ocena_wydajnosci DESC, cena_rynkowa_pln_od ASC LIMIT 1"
        )
        cursor.execute(ram_up_sql, (ram['typ_pamieci'], ram_up_cap))
        better_ram = cursor.fetchone()
        if better_ram:
            rules_fired += 1
            spent_total = spent_total - float(ram['cena_rynkowa_pln_od']) + float(better_ram['cena_rynkowa_pln_od'])
            remaining = budget - spent_total
            ram = better_ram
            logs.append(f"Reguła 11a (Optymalizacja RAM): Wolne środki przeznaczono na {ram['pojemnosc_calkowita_gb']}GB {ram['typ_pamieci']}.")

    if dysk and remaining >= 150.0:
        upgrade_cap = float(dysk['cena_pln']) + remaining
        if cel in ['gaming', 'workstation']:
            up_sql = (
                "SELECT * FROM dyski WHERE cena_pln <= %s AND pojemnosc_gb > %s "
                "AND interfejs = 'NVMe' AND status_generacji = 'aktualny' "
                "ORDER BY pojemnosc_gb DESC, ocena_wydajnosci DESC LIMIT 1"
            )
        else:
            up_sql = (
                "SELECT * FROM dyski WHERE cena_pln <= %s AND pojemnosc_gb > %s "
                "AND typ_dysku = 'SSD' ORDER BY pojemnosc_gb DESC, ocena_wydajnosci DESC LIMIT 1"
            )
        cursor.execute(up_sql, (upgrade_cap, dysk['pojemnosc_gb']))
        better_dysk = cursor.fetchone()
        if better_dysk:
            rules_fired += 1
            spent_total = spent_total - float(dysk['cena_pln']) + float(better_dysk['cena_pln'])
            remaining = budget - spent_total
            dysk = better_dysk
            logs.append(f"Reguła 11b (Optymalizacja reszty): Wolne środki przeznaczono na większy SSD {dysk['pojemnosc_gb']}GB.")

    conn.close()
    exec_time = round(time.perf_counter() - start_time, 4)

    if cpu and mobo and ram and psu:
        return {
            'cpu': cpu,
            'gpu': gpu,
            'mobo': mobo,
            'ram': ram,
            'dysk': dysk,
            'case': case,
            'psu': psu,
            'cooler_reserved': cooler_reserved,
            'total_price': round(spent_total, 2),
            'budget_left': round(remaining, 2),
            'budget': budget,
            'cel': cel,
            'cpu_pref': cpu_pref,
            'gpu_pref': gpu_pref,
            'future_proof': future_proof,
            'logs': logs,
            'exec_time': exec_time,
            'rules_fired': rules_fired,
            'total_combinations': f"{total_combinations:,}".replace(",", " ")
        }
    else:
        return {
            'error': 'Nie udało się złożyć pełnego zestawu w tym budżecie (zbyt niska kwota dla wybranych wymagań).',
            'budget': budget,
            'cel': cel,
            'cpu_pref': cpu_pref,
            'gpu_pref': gpu_pref,
            'future_proof': future_proof,
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
