# <PC BUILDER>

**Zespół:** Z8 · grupa L2 · **Repozytorium:** <https://github.com/twdoppe/si-l2-z8-PCBuilder>
Sztuczna inteligencja — laboratorium · Collegium Da Vinci · rok akad. 2026/2027


## 1. Problem *(rubryka A)*


Dzisiaj wybór poszczególnych części do komputera to niezły kanał. Po pierwsze, wybór komputera nie oznacza dzisiaj, że będzie on pasował absolutnie każdemu: ktoś chce prosty, podstawowy PC do nieskomplikowanych zadań, ktoś inny potrzebuje w miarę sprawnej maszyny do codziennych obowiązków, na przykład do pracy, a jeszcze ktoś inny – maksymalnie wydajnego sprzętu, który uruchomi dzisiaj wszystkie gry bez wyjątku i poradzi sobie z bardzo dużymi projektami w branży IT. Po drugie, sprawdzanie wszystkich podzespołów pod kątem kompatybilności to kompletna udręka, ponieważ człowiek musi poświęcić sporo czasu, aby to wszystko wyszukać, zweryfikować, czy części do siebie pasują, a na koniec gdzieś to wszystko zapisać, zapamiętać i sprawdzić, czy całość zmieści się w założonym budżecie. Dlatego naszym rozwiązaniem tego problemu jest system, który automatycznie dobiera wszystkie podzespoły komputera według preferencji użytkownika, a mianowicie: ceny, konkretnego GPU/CPU, które chce on widzieć w swoim PC, oraz przeznaczenia, do jakiego sprzęt jest mu potrzebny. Dzięki temu na sam koniec zyskujemy zaoszczędzony czas użytkownika i redukcję całego problemu praktycznie do zera (ponieważ nasz system generuje na wyjściu swego rodzaju specyfikację, którą użytkownik może później wykorzystać jako notatkę podczas składania PC).

## 2. Dlaczego SI i dlaczego ta technika *(B · 7 pkt)*


Pojawia się tutaj pytanie – dlaczego w naszym projekcie wykorzystaliśmy wnioskowanie regułowe, a nie zwykły kod czy inną metodę SI? Zwykły algorytm z instrukcjami warunkowymi if-else nie wystarczy, ponieważ przy tylu parametrach kod stałby się nieczytelny, trudny w utrzymaniu i nie potrafiłby sam wyciągać nowych wniosków. I używanie alternatywnej metody (sieci neuronowej albo klasycznego uczenia maszynowego) też byłoby nieodpowiednie, bo wtedy system mógłby generować zestawy losowo lub z błędami, zamiast ściśle trzymać się reguł ceny/kompatybilności/przeznaczenia. Właśnie dlatego wybraliśmy wnioskowanie regułowe, które najlepiej nadaje się do stworzenia naszego silnika i gwarantuje pełną zgodność podzespołów.

## 3. Dane *(B · 8 pkt)*


Mówiąc o danych, które wykorzystujemy w naszym projekcie, są to zwykłe zbiory danych (tabele) w formacie SQL. Łącznie do działania projektu potrzebujemy 7 tabel: procesory, karty_graficzne, pamiec_ram, dyski, plyty_glowne, power_supplies oraz pc_cases. Część z tych zbiorów danych pobraliśmy z różnych repozytoriów (d.p. GitHub), natomiast pozostała część to dane syntetyczne (wygenerowane przez SI). Korzystając z tych tabel, opieraliśmy się przede wszystkim na zawartych w nich parametrach technicznych, aby nasz system mógł działać prawidłowo.

## 4. Rozwiązanie *(A · 10 pkt, B · 5 pkt)*


-Schemat działania systemu:
  1. Użytkownik na początku wpisuje budżet (kwotę w złotych, w jakiej ma się zmieścić cały zestaw komputerowy).
  2. Następnie użytkownik wybiera cel – do czego komputer ma być przeznaczony (jeśli wybierze opcję gaming, odblokowuje się dodatkowa możliwość wyboru preferowanego producenta GPU – NVIDIA lub Radeon).
  3. W kolejnym kroku użytkownik wybiera preferowanego producenta CPU – Intel lub AMD (oraz opcjonalnie GPU, jeśli wcześniej zaznaczył tryb gaming).
  4. Na sam koniec użytkownik klika przycisk „Zbuduj komputer”. Silnik wnioskowania uruchamia reguły na bazie danych MySQL i w rezultacie, przy uwzględnieniu wszystkich wpisanych parametrów, użytkownik otrzymuje kompletny zestaw PC z podzespołami dobranymi pod kątem pełnej kompatybilności technicznej, wybranego celu oraz zadanego budżetu.
-Opis algorytmu SI z jego podstawą logiczno-matematyczną:
  1. System wykorzystuje wnioskowanie regułowe w przód (forward chaining) oparte na rachunku zdań i logice pierwszego rzędu (JEŻELI warunek_1 ORAZ warunek_2, TO wniosek), co pozwala na wyprowadzanie nowych faktów z danych wejściowych użytkownika (np. wyliczenie wymaganego zapasu mocy zasilacza na podstawie sumy poboru mocy TDP dobranego procesora i karty graficznej).
  2. Przeszukiwanie przestrzeni stanów odbywa się metodą przycinania gałęzi (odrzucanie całych grup niekompatybilnych części już na wczesnym etapie wnioskowania, np. poprzez dopasowanie gniazda socket oraz typu pamięci memory_type), zamiast sprawdzania każdej kombinacji po kolei.
  3. Wybór najlepszego zestawu spośród pasujących wariantów realizuje funkcja oceny dopasowania, która maksymalizuje wykorzystanie budżetu bez jego przekroczenia oraz minimalizuje różnicę wydajnościową między CPU a GPU (unikając tzw. bottlenecku), według zasady: Ocena = (Suma cen podzespołów / Budżet) - kara za dysproporcję wydajności, przy warunku, że suma cen nie przekracza budżetu.

-Kluczowe parametry i ich wartości:
  1. Alokacja budżetu według presetu celu (wagi procentowe):
     - Gaming: 45% budżetu przeznaczane jest na kartę graficzną (GPU), a 22% na procesor (CPU).
     - Workstation: 30% na GPU oraz 35% na CPU.
     - Office: 0% na dedykowane GPU oraz 40% na CPU ze zintegrowanym GPU.
  2. Dynamiczne przenoszenie reszty budżetu (Rollover) i rezerwa na chłodzenie:
     - Kwota zaoszczędzona na jednym podzespole jest automatycznie doliczana do limitu kolejnych komponentów (np. na pojemniejszy dysk SSD lub większą ilość pamięci RAM).
     - Jeżeli wybrany procesor ma współczynnik $\text{TDP} > 65\text{ W}$, silnik automatycznie rezerwuje od 100 do 300 PLN na układ chłodzenia CPU.
  3. Reguła Anti-Bottleneck i tryb Future-proof:
     - Przy doborze karty graficznej z wyższego segmentu (wysoki / entuzjasta) system wymusza procesor wyposażony w co najmniej 6 rdzeni.
     - Zaznaczenie opcji Future-proof ogranicza wybór wyłącznie do platform opartych na pamięciach DDR5.
  4. Zapas mocy zasilacza (PSU) oraz twarde reguły kompatybilności:
     - Moc zasilacza wyliczana jest w bezpiecznym korytarzu $1,25\times\text{–}1,65\times$ realnego zapotrzebowania zestawu na energię.
     - Wymuszana jest pełna zgodność sprzętowa: gniazdo procesora (CPU.socket == MOBO.socket), standard pamięci (DDR4 / DDR5), format płyty głównej z obudową (ATX, Micro-ATX) oraz obsługa wymaganego złącza zasilania GPU (np. 12V-2x6 / PCIE5).

## 5. Ewaluacja *(B · 8 pkt)*


Metryka i punkt odniesienia:
Jako punkt odniesienia przyjęliśmy gotowe zestawy komputerowe dostępne w polskich sklepach (Komputronik, x-kom, OleOle!, dell24.pl) w identycznych przedziałach cenowych (5 000–10 000 PLN) oraz kategoriach (Gaming / Office). Porównaliśmy oba warianty na podstawie rzeczywistych parametrów technicznych CPU i GPU (architektura, liczba rdzeni, pojemność VRAM ). Dodatkowo zmierzyliśmy złożoność obliczeniową silnika względem prostego filtra kaskadowego (iloczyn kartezjański tabel w bazie MySQL).

| Przypadek (Budżet i kategoria) | Zestaw ze sklepu (Punkt odniesienia) | Zestaw z naszego systemu | Werdykt (porównanie specyfikacji) |
|---|---|---|---|
| 01 / 7 000 PLN (Gaming) | Komputronik LEVEL GO F02 (Core Ultra 5 225F / RTX 5060 8GB) | AMD Ryzen 7 7800X3D / Radeon RX 7800 XT 16GB | Wygrana systemu (kultowy procesor X3D do gier oraz 16 GB VRAM zamiast 8 GB w RTX 5060, mimo starszej generacji GPU) |
| 02 / 8 000 PLN (Gaming) | x-kom SMX SE (Core i5-14400F / RTX 5060 Ti) | AMD Ryzen 7 7800X3D / GeForce RTX 4070 Ti 12GB | Wygrana systemu (wyższa półka GPU i procesor 3D V-Cache bijący i5-14400F w grach, choć karta pochodzi z poprzedniej generacji) |
| 03 / 9 000 PLN (Gaming) | OleOle! HP OMEN 35L (Ryzen 7 8700F / RX 9060 XT) | AMD Ryzen 7 9850X3D / Radeon RX 9070 XT 16GB | Zdecydowana wygrana systemu (najnowsza generacja CPU i GPU z wyższego segmentu kontra budżetowy 8700F z małym cache) |
| 04 / 10 000 PLN (Gaming) | Komputronik LEVEL GO F20 (Core Ultra 5 225F / RTX 5060) | AMD Ryzen 7 9850X3D / GeForce RTX 5070 Ti 16GB | Zdecydowana wygrana systemu (flagowy procesor gamingowy i karta klasy 5070 Ti kontra podstawowy RTX 5060 w sklepie za 10 tys. PLN) |
| 05 / 5 000 PLN (Office) | Komputronik Lenovo IdeaCentre (Core Ultra 7 265 / iGPU) | Core Ultra 7 270K Plus (24 rdzenie) / iGPU | Lekka przewaga systemu (więcej rdzeni i wyższe taktowanie, choć zestaw sklepowy ma fabrycznie cichszą, kompaktową obudowę) |
| 06 / 5 500 PLN (Office) | dell24.pl DELL Pro Slim (Core i5-14500 / iGPU) | Core i7-14700K (20 rdzeni) / iGPU | Wygrana systemu (20 rdzeni z odblokowanym mnożnikiem kontra biurowe i5-14500 o niższym taktowaniu) |
| 07 / 6 000 PLN (Office) | Komputronik ThinkStation P3 (Core Ultra 7 265 / iGPU) | Core i7-14700 (20 rdzeni) / iGPU | Remis / przewaga sklepu (zbliżona wydajność wielowątkowa, ale sklep oferuje nowszą architekturę Arrow Lake o niższym TDP) |
| 08 / 6 500 PLN (Office) | x-kom Dell Pro Tower (Core Ultra 7 265K / iGPU) | Core i9-14900KS (24 rdzenie) / iGPU | Remis ze wskazaniem na system (i9-14900KS wygrywa surową mocą obliczeniową, ale kosztem znacznie wyższego poboru prądu i temperatur) |

Wnioski z ewaluacji (uczciwa ocena mocnych i słabych stron):
W 6 na 8 przypadków nasz system ekspertowy wyraźnie wygrywa z gotowymi zestawami sklepowymi pod względem wydajności w grach, klasy układu graficznego oraz pojemności pamięci VRAM (szczególnie w segmencie Gaming, gdzie sklepy w kwocie 7 000–10 000 PLN montują procesory i5 / Ultra 5 oraz karty klasy RTX 5060, podczas gdy nasz system dobiera wyspecjalizowane jednostki Ryzen 7 7800X3D / 9850X3D oraz karty od RX 7800 XT aż po RTX 5070 Ti). Należy jednak uczciwie zaznaczyć ograniczenia naszej bazy: w niższych budżetach gamingowych (7 000–8 000 PLN) oraz w konfiguracjach biurowych silnik sięga po układy poprzednich generacji (np. RX 7800 XT, RTX 4070 Ti czy Intel 14. generacji), które oferują wyższą czystą wydajność w swojej cenie, ale cechują się wyższym poborem mocy (TDP) niż najnowsze układy z oferty sklepowej. W 2 przypadkach biurowych (07 i 08) zestawy sklepowe osiągają zbliżony poziom, wygrywając kulturą pracy i energooszczędnością. Pod kątem algorytmicznym silnik zachowuje pełną przewagę nad prostym filtrem kaskadowym – zamiast przeszukiwać pełny iloczyn kartezjański tabel, podejmuje decyzję w 10–11 regułach w czasie poniżej 0,05 s.

Strony internetowe do wariantów z punktu odniesienia:
1: https://www.komputronik.pl/product/996108/level-go-f02-ultra-5-rtx-5060-16gb-1tb-w11h.html
2: https://www.x-kom.pl/p/1585052-desktop-smx-se-ukiyo-i5-14400f-32gb-1tb-rtx5060ti-w11x.html#Specyfikacja
3: https://www.oleole.pl/komputery-stacjonarne-pc/hp-pc-hp-omen-35l-r7-16-1-9060xt-nos.bhtml?from=ceneo&p=8999.00&cr=0&t=20261125-1117&utm_source=ceneo&utm_medium=referral&ceneo_cid=746c2fbd-5a62-f0a5-e200-c4755adaf556
4: https://www.komputronik.pl/product/996126/komputer-level-go-f20-ultra-5-rtx-5060-32gb-2tb-w11h.html
5: https://www.komputronik.pl/product/1024777/komputer-lenovo-ideacentre-tower-ultra-7-265-16gb-512gb-no-os.html
6: https://dell24.pl/p/20053/Komputer-DELL-Pro-Slim-QCS1250-SFF-i5-14500-32GB-512GB-SSD-W11P-3YPS
7: https://www.komputronik.pl/product/1036055/komputer-lenovo-thinkstation-p3-tower-gen-2-ultra-7-265-32gb-1tb-win11pro-czarny.html#Cechy
8: https://www.x-kom.pl/p/1532141-desktop-dell-pro-tower-essential-ultra-7-265k-16gb-512gb-win11p.html#Specyfikacja

## 6. Wymagania niefunkcjonalne *(A · 5 pkt)*


Czas potrzebny na dobranie zestawu komputerowego według wymagań podanych przez użytkownika wynosi zazwyczaj poniżej 1 sekundy (czasami zajmuje do 1,4–1,5 sekundy). Kwestię tego, co dzieje się w sytuacji, gdy użytkownik wprowadzi nieprawidłowe dane, rozwiązaliśmy w następujący sposób: gdy podane zostaną błędne wartości (na przykład cena poniżej minimum), system wyświetla komunikat o błędzie dotyczącym budżetu (informując, że musi on być wyższy niż minimalnie wskazana kwota). Wyniki dla poszczególnych podzespołów (w szczególności w odniesieniu do CPU) mogą się czasami powtarzać.

## 7. Ograniczenia *(E · 4 pkt)*


Mamy szczególny przypadek, w którym nasz system może zawieść: gdy wybierzemy na przykład budżet od 1500 do 4500–5000 złotych, system nie jest w stanie odnaleźć odpowiednich podzespołów, które zmieściłyby się w tej kwocie. Gdybyśmy mieli znacznie więcej czasu, dopracowalibyśmy samą logikę kategorii cenowych (być może system dobierałby częściowy zestaw PC bez niektórych komponentów lub działałby w inny sposób) — tak czy inaczej, rozwiązalibyśmy ten problem, mając więcej czasu na rozwój projektu.

## 8. Zastosowania w praktyce *(E · 4 pkt)*


Podobne systemy ekspertowe i konfiguratory oparte na regułach kompatybilności są powszechnie stosowane w branży e-commerce oraz handlu sprzętem komputerowym i elektronicznym:
 1. Sklepy komputerowe i konfiguratory PC: Najbardziej znanymi przykładami są platforma PCPartPicker, a na polskim rynku konfiguratory zestawów w sklepach x-kom, Morele.net czy Komputronik. Wykorzystują one bazy wiedzy o parametrach podzespołów, aby automatycznie blokować wybór niekompatybilnych części (np. płyty głównej z innym gniazdem niż wybrany procesor) oraz wyliczać zapotrzebowanie na moc zasilacza.
 2. Wsparcie sprzedaży B2B i doradztwo IT: Systemy regułowe są używane przez działy zaopatrzenia oraz dystrybutorów sprzętu (np. Dell, Lenovo) do szybkiego tworzenia spersonalizowanych stacji roboczych i serwerów pod konkretne wymagania biznesowe i budżetowe klienta, bez konieczności każdorazowego angażowania inżyniera sprzedaży.
 3. Konfiguratory produktów w innych branżach (CPQ – Configure, Price, Quote): Analogiczna logika wnioskowania regułowego stosowana jest m.in. w motoryzacji (konfiguratory samochodów, gdzie wybór określonego silnika wymusza konkretny typ skrzyni biegów i zawieszenia) oraz w przemyśle przy doborze komponentów automatyki.

## 9. Zespół *(D · 8 pkt)*


| Osoba | Za co odpowiadała |
| Mykola Haponov | interfejs użytkownika |
| Artem Chornyi | dokumentacja i prezentacja |
| Danyl Pavlenko | rdzeń projektu |

W kwestii ról w projekcie możemy powiedzieć jedno – od czasu do czasu ulegały one drobnym zmianom: jedna osoba pomagała drugiej przy tworzeniu dokumentacji (n. p. karty tematu), ktoś inny wspierał prace nad interfejsem, a kolejna osoba pomagała przy samym silniku wnioskowania. Tak czy inaczej, wszyscy mniej więcej pracowali w rolach ustalonych na samym początku, nie bez wzajemnej pomocy.

## 10. Uruchomienie *(C · 4 pkt)*

Aby uruchomić projekt lokalnie na własnym komputerze, należy wykonać poniższe kroki:

1. Wymagania wstępne:

-Zainstalowany Python 3.11+

-Zainstalowany pakiet XAMPP (z uruchomionym serwerem bazy danych MySQL na domyślnym porcie 3306, użytkownik root, bez hasła)

2. Przygotowanie bazy danych:

-Uruchom XAMPP Control Panel i włącz moduł MySQL (oraz Apache, jeśli chcesz skorzystać z phpMyAdmin).

-Otwórz panel http://localhost/phpmyadmin, utwórz nową bazę danych o nazwie pckonfig i zaimportuj do niej przygotowane tabele SQL (procesory, karty_graficzne, plyty_glowne, pamiec_ram, dyski, pc_cases, power_supplies).
3. Pobranie repozytorium i instalacja zależności:
-Otwórz terminal i wpisz kolejno:

```
git clone https://github.com/twdoppe/si-l2-z8-PCBuilder
cd si-l2-z8-PCBuilder
pip install flask pymysql

```
4. Uruchomienie aplikacji:
-W katalogu projektu uruchom serwer Flask poleceniem:

```
python app.py

```
5. Wynik działania:
-Po uruchomieniu serwera otwórz przeglądarkę internetową i wejdź pod adres:

```
http://127.0.0.1:5000/

```
Na ekranie pojawi się formularz, w którym należy wpisać budżet, wybrać przeznaczenie komputera oraz preferencje sprzętowe, a po kliknięciu przycisku „Zbuduj komputer” system wyświetli gotowy, kompatybilny zestaw podzespołów wraz z logami wnioskowania i opcją pobrania konfiguracji do pliku .txt

## 11. Narzędzia AI

Powiedzmy to tak: w naszym projekcie częściowo wykorzystaliśmy SI do wygenerowania pojedynczych danych, czyli do zbiorów danych (datasetów) i tworzenia stylu strony internetowej, natomiast cała reszta została wykonana ręcznie.
