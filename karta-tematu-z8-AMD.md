# Karta zgłoszenia tematu projektu

**Grupa:** L2 · **Zespół:** Z8 · **Data:** 04/11/2026
Sztuczna inteligencja — laboratorium · Collegium Da Vinci · rok akad. 2026/2027


## 1. Skład zespołu

> Rola jest wstępna — można ją zmienić w trakcie projektu bez uzgadniania.

| Imię i nazwisko | Nr albumu | Rola (wstępna) |
|Mykola Haponov|31105|interfejs użytkownika i przygotowanie danych|
|Artem Chornyi |31060 |prezentacja i dokumentacja|
|Danyl Pavlenko |31019 |kod rdzenia SI i silnik wnioskowania|


## 2. Roboczy tytuł (PL)
System rekomendacji podzespołów komputerowych

## 3. Tytuł (EN)
Computer component recommendation system

## 4. Problem — co system ma robić i dla kogo (3–5 zdań)
Wybor odpowiednich części do komputera jest dzisiaj trudny, bo na rynku jest mnóstwo sprzętu o skomplikowanych parametrach. Zwykły użytkownik musi spędzić mnóstwo czasu, żeby sprawdzić, czy wszystko będzie ze sobą działać. Nasz system ma pomóc początkującym, graczom i osobom szukającym komputera do pracy w szybkim dobraniu gotowego, w pełni kompatybilnego zestawu bez konieczności ręcznego sprawdzania specyfikacji każdej części.

## 5. Technologia SI

- [ ] sieć neuronowa
- [x] system ekspertowy / wnioskowanie regułowe
- [ ] algorytm genetyczny
- [ ] klasyczne uczenie maszynowe

**5a. Dlaczego zwykły algorytm nie wystarczy:**
Gdybyśmy chcieli napisać to zwykłym kodem, musielibyśmy stworzyć ogromną i skomplikowaną sieć warunków if-else dla każdej możliwej kombinacji części. Przy tylu parametrach (gniazdo procesora, moc zasilacza, typ pamięci itd.) taki kod szybko stałby się nie czytelny i bardzo trudny w utrzymaniu. Zwykły algorytm wykonuje sztywne kroki po kolei i nie potrafi sam tworzyć nowych wniosków na podstawie podanych danych (np. automatycznie przeliczyć zapasu mocy zasilacza po wybraniu konkretnej karty graficznej).

**5b. Dlaczego system ekspertowy:**
Zwykły filtr potrafi tylko odrzucić części, które nie pasują do jednego wybranego parametru. Nasz silnik regułowy działa inaczej – startuje od tego, czego potrzebuje użytkownik (np. komputer do gier za 5000 zł), i na tej podstawie sam wyciąga kolejne wnioski (np. "karta graficzna powinna kosztować około 45% budżetu", "potrzebujemy zasilacza o mocy minimum 650W"). Przeszukiwanie bazy będzie działć tak, że system od razu odrzuca całe grupy części które nie będą pasować, zamiast spawdzenia każdej możliwej kombinacji po kolei. Poprawność wyników zależy od tego, jak dobrze napiszemy bazy wiedzy, dlatego dokładnie przetestujemy nasze reguły na przygotowanych wcześniej przykładach.

## 6. Dane

- Źródło: Baza danych podzespołów, którą zaimportujemy do relacyjnej bazy SQL. Baza będzie uruchomiona lokalnie przez XAMPP (MySQL).
- Rozmiar / format: Tabele SQL które mają ważne parametry techniczne (np. socket, memory_type, tdp, price). Przygotujemy sensowną liczbę rekordów, której wystarczy żeby pokazać różne warianty sprzętu i sprawdzić, czy nasz silnik działa poprawnie.
- Czy dane są już dostępne? **Tak** — Mamy już prawie datasety z repozytoriów i część datasetów ręcznych. Teraz wystarczy to ogarnąć: wyczyścić z marketingu, wyrównać formaty i zaimportować do SQL-a.

## 7. Stos technologiczny
Python 3.11+, własny silnik wnioskowania regułowego, baza danych MySQL w XAMPP i prosta strona www (HTML/CSS) jako interfejs.

## 8. Kryterium sukcesu

- Metryka i próg: Przygotujemy ręcznie 20 przykładowych wymagań (np. komputer do gier za 4000 zł) i sprawdzimy, czy system podaje poprawne zestawy. Będziemy też sprawdzać, czy system dobrze wykorzystuje budżet i czy nie dobiera słabego procesora do bardzo mocnej karty graficznej. Czas odpowiedzi systemu ma być krótszy niż 2 sekundy.
- Punkt odniesienia (prosta metoda, z którą porównacie wynik): Prosty filtr kaskadowy. Stworzymy go dla celów testowych, żeby porównać go z naszym systemem. Porównamy, ile trzeba prób dla zwykłego filtru, a ile dla silniku regułowego, żeby znaleźć pasujący zestaw.

## 9. Zakres minimalny (co powstanie na pewno)
Baza wiedzy które ma reguły kompatybilności dla głównych części (procesor, karta graficzna, RAM, płyta główna, zasilacz). Własny silnik wnioskowania, która będzie wybierać najlepszy zestaw. Prosty interfejs w HTML połączony z bazą danych oraz pełna dokumentacja (w tym wymagana część po angielsku).

## 10. Zakres opcjonalny (co dorobimy, jeśli starczy czasu)
Troche ładniejszy wygląd strony, dodanie obsługi obudów i chłodzenia oraz możliwość zapisania wygenerowanego zestawu do pliku PDF albo TXT.

## 11. Repozytorium
https://github.com/twdoppe/si-l2-z8-PCBuilder

## 12. Główne ryzyko i plan awaryjny
Największym ryzykiem jest to, że zależności między wszystkimi częściami będą zbyt skomplikowane do opisania. Mamy taki plan awaryjny, że w razie problemów ograniczymy bazę wiedzy do 3 głównych elementów (CPU, płyta główna, RAM) i stałych modeli zasilaczy.
