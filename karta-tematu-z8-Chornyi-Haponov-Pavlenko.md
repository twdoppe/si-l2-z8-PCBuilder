# Karta zgłoszenia tematu projektu

**Grupa:** L2 · **Zespół:** Z8 · **Data:** 28/10/2026
Sztuczna inteligencja — laboratorium · Collegium Da Vinci · rok akad. 2026/2027
Oddajecie mailem do **22.10, 16:45**, temat `SI L2 · Z<nr zespołu> · karta`.

## 1. Skład zespołu

> Rola jest wstępna — można ją zmienić w trakcie projektu bez uzgadniania.

| Imię i nazwisko | Nr albumu | Rola (wstępna) |
|Mykola Haponov|31105|interfejs użytkownika i przygotowanie danych|
|Artem Chornyi |31060 |prezentacja i dokumentacja|
|Danyl Pavlenko |31019 |kod rdzenia SI i silnik wnioskowania|


## 2. Roboczy tytuł (PL)
System rekomendacji podzespolow komputerowych

## 3. Tytuł (EN)
Computer component recommendatiton system

## 4. Problem — co system ma robić i dla kogo (3–5 zdań)
Wybor komponentow do wspolczesnego komputera stal sie niezwykle skomplikowanym zadaniem ze wzgledy na to ze jest ogromny asortyment komponentow i ich specyfikacje techniczne.
Reczne poszukiwanie odpowiednich wariantow wymaga ogromnego nakladu czasu. 
System jest przeznaczony dla osob poczatkujacych lub graczej i profesjonalistow ktore potrzebuja szybkiego doboru lub sprawdzenia w pelni kompatybilnych podzespolow komputerowych.

## 5. Technologia SI

- [ ] sieć neuronowa
- [+] system ekspertowy / wnioskowanie regułowe
- [ ] algorytm genetyczny
- [ ] klasyczne uczenie maszynowe

Dlaczego ta technologia pasuje do tego problemu (2–3 zdania):
Dobór komponentów komputerowych opiera się na twardych i jednoznacznych regułach kompatybilności technicznej (np. typ gniazda procesora, pobór mocy, typ pamięci RAM).
System ekspertowy pozwala na precyzyjne odzwierciedlenie wiedzy dziedzinowej w postaci reguł warunkowych.
Dzięki temu system gwarantuje 100% poprawność i wyjaśnialność rekomendacji bez ryzyka wystąpienia błędów wynikających z czarnych skrzynek modeli statystycznych.

## 6. Dane

- Źródło: Publiczne bazy danych podzespołów (np. zoptymalizowane pliki JSON/CSV z danymi ze sklepów komputerowych lub serwisów typu PCPartPicker)
- Rozmiar / format: Baza w formacie JSON/CSV zawierająca około 500–1000 rekordów ze szczegółową specyfikacją techniczną komponentów (CPU, GPU, RAM, Płyta główna, Zasilacz)
- Czy dane są już dostępne? tak / nie — plan pozyskania:

## 7. Stos technologiczny
Python 3.11+, Pyknow / Experta lub własny silnik wnioskowana regułowego, Streamlit (dla interfejsu użytkownika), Pandas (do przetwarzania danych).
## 8. Kryterium sukcesu

- Metryka i próg:100% poprawności walidacji kompatybilności w testowych konfiguracjach sprzętowych oraz czas generowania rekomendacji poniżej 2 sekund.
- Punkt odniesienia (prosta metoda, z którą porównacie wynik):Ręczne składanie zestawu przez użytkownika na podstawie tabeli kompatybilności lub prosty filtr kaskadowy bez silnika regułowego.

## 9. Zakres minimalny (co powstanie na pewno)
Baza wiedzy z regułami kompatybilności podstawowych podzespołów (CPU, GPU, RAM, Motherboard, PSU), silnik wnioskowania dobierający sprzęt na podstawie budżetu i przeznaczenia (gry/praca) oraz prosty interfejs tekstowy lub webowy.
## 10. Zakres opcjonalny (co dorobimy, jeśli starczy czasu)
Rozbudowany interfejs graficzny, obsługa dodatkowych parametrów (obudowa, chłodzenie, wymiary), wyliczanie szacowanego zużycia energii oraz funkcja eksportu gotowego zestawu do pliku PDF/TXT.
## 11. Repozytorium
https://github.com/twdoppe/si-l2-z8-PCBuilder


## 12. Główne ryzyko i plan awaryjny
Zbyt duża złożoność reguł i powiązań między wszystkimi typami podzespołów. Plan awaryjny: Ograniczenie bazy wiedzy do głównych kategorii (CPU, GPU, RAM, Płyta główna) i stałych standardów budżetowych.
---

*Decyzja prowadzącego:* [ ] zatwierdzony  [ ] do poprawy · *Uwagi:*
