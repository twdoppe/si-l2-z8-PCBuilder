import pymysql
import time

# konfiguracja bazy danych xampp
DB_CONFIG = {
    'host': '127.0.0.1',
    'user': 'root',
    'password': '',
    'database': 'pckonfig',
    'cursorclass': pymysql.cursors.DictCursor
}

def run_rule_engine(budget, cel):
    print(f"\n wnioskowanie regulowe (budzet: {budget} pln, cel: {cel}) ")
    try:
        conn = pymysql.connect(**DB_CONFIG)
    except pymysql.MySQLError as e:
        print(f"blad polaczenia: {e}")
        return

    cursor = conn.cursor()
    start_time = time.time()
    rules_fired = 0
    
    
    if cel.lower().strip() == 'gaming':
        gpu_budget = budget * 0.45
        cpu_budget = budget * 0.20
    else:
        gpu_budget = budget * 0.30
        cpu_budget = budget * 0.30
        
    rules_fired += 1
    cursor.execute("SELECT * FROM karty_graficzne WHERE cena_rynkowa_pln <= %s ORDER BY cena_rynkowa_pln DESC LIMIT 1", (gpu_budget,))
    gpu = cursor.fetchone()
    

    rules_fired += 1
    cursor.execute("SELECT * FROM procesory WHERE cena_pln <= %s ORDER BY cena_pln DESC LIMIT 1", (cpu_budget,))
    cpu = cursor.fetchone()
    

    mobo_budget = budget * 0.15
    rules_fired += 1
    if cpu:
        cursor.execute("SELECT * FROM plyty_glowne WHERE socket = %s AND typ_pamieci = %s AND cena_pln <= %s ORDER BY cena_pln DESC LIMIT 1", 
                       (cpu['socket'], cpu['pamiec_ram'], mobo_budget))
        mobo = cursor.fetchone()
    else:
        mobo = None
        

    ram_budget = budget * 0.10
    rules_fired += 1
    if mobo:
        cursor.execute("SELECT * FROM pamiec_ram WHERE typ_pamieci = %s AND cena_rynkowa_pln_od <= %s ORDER BY cena_rynkowa_pln_od DESC LIMIT 1", 
                       (mobo['typ_pamieci'], ram_budget))
        ram = cursor.fetchone()
    else:
        ram = None
        

    rules_fired += 1
    if gpu and cpu and mobo and ram:
        req_power = gpu['zalecany_zasilacz_w'] + cpu['tdp_w'] + 50
        used_budget = float(cpu['cena_pln']) + float(gpu['cena_rynkowa_pln']) + float(mobo['cena_pln']) + float(ram['cena_rynkowa_pln_od'])
        psu_budget = budget - used_budget
        cursor.execute("SELECT * FROM power_supplies WHERE wattage_w >= %s AND price_pln <= %s ORDER BY price_pln ASC LIMIT 1", 
                       (req_power, psu_budget))
        psu = cursor.fetchone()
    else:
        psu = None

    end_time = time.time()
    conn.close()
    
    print(f"liczba prob: {rules_fired}")
    print(f"czas wykonania: {end_time - start_time:.4f} s")
    
    if cpu and gpu and mobo and ram and psu:
        total = float(cpu['cena_pln']) + float(gpu['cena_rynkowa_pln']) + float(mobo['cena_pln']) + float(ram['cena_rynkowa_pln_od']) + float(psu['price_pln'])
        print(f"znaleziony zestaw za {total:.2f} PLN:")
        print(f"CPU >>  {cpu['producent']} {cpu['model']} (TDP: {cpu['tdp_w']}W)")
        print(f"GPU >>  {gpu['producent']} {gpu['model']} (Zalecany zasilacz: {gpu['zalecany_zasilacz_w']}W)")
        print(f"MBO >> {mobo['producent']} {mobo['model']} (Socket: {mobo['socket']})")
        print(f"RAM >>  {ram['producent']} {ram['model']} ({ram['typ_pamieci']})")
        print(f"PSU >> {psu['manufacturer']} {psu['model']} ({psu['wattage_w']}W)")
        print(f"\n porownanie: ")
        print(f"Zysk wydajnosciowy w iteracjach: Filtr kaskadowy musi przebic tysiace wierszy, system regulowy odpala tylko {rules_fired} krokow wnioskowania.")
    else:
        print("nie udalo sie znalesc zestaw z takim budzetem.")

if __name__ == '__main__':
    try:
        b = float(input("budzet pln: "))
        c = input("cel - gaming / praca: ")
        run_rule_engine(b, c)
    except ValueError:
        print("budzet musi byc liczba!")
