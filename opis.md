# Baza biletów
Izabela Tylek, Mateusz Szkudlarek

## Tematyka i opis

Nasz projekt modeluje bazę biletów klubu piłkarskiego (opartą o istniejący klub). 

Model zawiera następujące elementy:
- Układ stadionu: sektory, rzędy, miejsca
- Historię meczów z podziałem na rodzaje (mecz pucharowy, puchar eu, mecz ligowy)
- Historię zakupionych karnetów
- Historię zakupionych biletów imiennych
- Trzy rodzaje karnetów: na pierwszą albo drugą rundę sezonu, albo na cały sezon
- Możliwość zwolnienia miejsca na pojedynczy mecz przez posiadacza karnetu
- Historię zmian cen karnetów (cena zależy od rodzaju meczu i sektora)
- Historię zmian cen biletów (cena zależy od sektora)
- Listę fanklubów i ich członków (członkowie fanklubów otrzymywać będą zniżki)
- Listę kar nałożonych na kibiców (kara równoznaczna jest z niemożnością zakupu biletu w pewnym okresie czasu)
- Listę restrykcji nałożonych na sektory

## Struktura bazy
- mecze:
- sektory:
- sektory\_rzędy:
- sektory\_restrykcje:
- bilety\_ceny:
- bilety:
- karnety\_ceny:
- karnety:
- zwolnione\_karnety:
- kibice:
- kibice\_restrykcje:
- fankluby:
- fankluby\_kibice:

## Napotkane problemy i sposoby rozwiązania
- Problem: jak w sposób zgodny z rzeczywistością zamodelować wysokość ceny dla danego miejsca
Rozwiązanie: uzależnienie ceny od rodzaju meczu i sektora
- Problem: w jaki sposób zamodelować istnienie trzech rodzajów karnetów
Rozwiązanie: dodanie do cen i typów karnetów dwóch booli: pierwsza\_runda, druga\_runda, kodujących typ karnetu
- Problem: w jaki sposób uniknąć pustych miejsc, gdy osoba posiadająca karnet nie chce stawić się na pojedynczy mecz
Rozwiązanie: dodanie możliwości zwalniania karnetów na pojedyncze mecze


## Kolejne etapy
- Dodanie podziału na rundy (używając porównania ze stałym między sezonami dniem podziału albo dodając dodatkowe pola)
- Dodanie ulg dla osób należących do fanklubów, dzieci, osób starszych
- Dodanie ograniczeń na zakup biletów na miejsca zajęte karnetem
- Przy zwalnianiu dodanie sprawdzenia, czy karnet istnieje
- Dodanie sprawdzenia, czy miejsce istnieje w danym sektorze i rzędzie
- Dodanie ograniczeń na zakup biletów dla osób objętych karami
- Wyświetlanie miejsc wolnych na dany mecz 
- Obliczanie ceny danego biletu/karnetu z uwzględnieniem ulg i zmian cen
- Wyświetlanie obecnych cen karnetów i biletów
