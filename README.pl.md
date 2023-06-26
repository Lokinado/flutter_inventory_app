<!--
+++
author = "Józef Stocki"
title = "Flutter Inventory App"
date = "2023-06-13"
description = "Aplikacja do przeprowadzania procesu inwentaryzacji."
summary = "Aplikacja do przeprowadzania procesu inwentaryzacji."
draft="true"
tags = [
    "android", 
    "dart",
    "nosql",
]
categories = [
    "mobile",
    "full stack",
    "group project"
]
+++
-->

![GitHub](https://img.shields.io/github/license/Lokinado/flutter_inventory_app?style=for-the-badge)
![GitHub language count](https://img.shields.io/github/languages/count/Lokinado/flutter_inventory_app?style=for-the-badge)
![GitHub top language](https://img.shields.io/github/languages/top/Lokinado/flutter_inventory_app?style=for-the-badge)

<p align="center">
    <h1 align="center" style="border-bottom: none; margin-bottom: 0">
        <strong>
            Inventory App
        </strong>
    </h1>

  <p align="center">
    Aplikacja do przeprowadzania procesu inwentaryzacji
    <br />
    <!--
    <a href="DEMO LINK"><strong>View Demo»</strong></a>
    -->
  </p>
</p>

<br><br>

# O Projekcie
Aplikacja do robienia inwentaryzacji tworzona na życzenie. Środki trwałe w pomieszczeniach są identyfikowane po numerze zapisanym na naklejce oraz odwzorowanym za pomocą kodu kreskowego. Istnieje możliwość rozróżnienia budynków, w każdym budynku pięter, a na każdym piętrze pomieszczeń.

[Github Repo](https://github.com/Lokinado/flutter_inventory_app)

![Image of application interface](https://raw.githubusercontent.com/Lokinado/flutter_inventory_app/main/Images/img.png "Interface!")

<br>

## Zespół
| **Kierownik Projektu** |
|:----------------------:|
|   [Krzysztof Borowski](https://github.com/Lokinado)   |

| **Lead Deweloper** | **Lead Tester** |  **Lead Writer**  |
|:------------------:|:---------------:|:-----------------:|
|    [Jeremi Lipiec](https://github.com/JeremiLipiec)   |  [Maciej Sieradz](https://github.com/MaciejSieradz) | Filip Sapiejewski |

|    **Deweloper**    |    **Tester**    |   **Writer**   |
|:-------------------:|:----------------:|:--------------:|
|     [Piotr Bauer](https://github.com/Bauero)     |  Jakub Dąbrowski |  Jakub Dolecki |
|   [Adam Ciesielski](https://github.com/AdamCI3)   |    [Jakub Litke](https://github.com/Litas0)   |  Szymon Boruń  |
| [Wojciech Sokołowski](https://github.com/Sokulele) |     Kasia Sak    |  Patryk Jeleń  |
|   [Arkadiusz Affek](https://github.com/ArekAff)   |     Sara Stec    | Konrad Bolesta |
|      [Jan Dusza](https://github.com/J-Dusza)      | [Piotr Chodkowski](https://github.com/piochod) | Piotr Majewski |
|    [Dawid Steciuk](https://github.com/Szyno9)    |   [Józef Stocki](https://github.com/4Maksio)   |                |

## Funkcjonalności
- Skanowanie kodów kreskowych kamerą
- Wpisywanie kodów kreskowych ręcznie
- Raportowanie poszczególnych pomieszczeń
- Walidacja umiejscowienia przedmiotów

<br>

## Stworzono Przy Użyciu
Frameworki i technologie warte wspomnienia.
* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
* [Firebase](https://firebase.google.com/)

<br>

# Pierwsze kroki
Flutter inventory app 

<br>

## Wymagania wstępne
* Dart SDK [Strona instalacyjna Dart SDK](https://dart.dev/get-dart)
* Flutter SDK [Strona instalacyjna Flutter SDK](https://docs.flutter.dev/get-started/install)
* Android studio [Strona instalacyjna Flutter SDK](https://docs.flutter.dev/get-started/install)

<br>

## Budowanie i uruchamianie
1. Sklonuj repozytorium
```sh
git clone https://github.com/Lokinado/flutter_inventory_app
```
2. Otwórz terminal w głównym katalogu projektu i zbuduj aplikacje korzystając z Flutter CLI
```sh
flutter build apk --split-per-abi
```
3. Wygenerowany plik .apk jest gotowy do zainstalowania na dowolnym telefonie z systemem android.

<br>

# Użytkowanie
Struktura aplikacji jest podzielona na 3 główne ekrany.

## Panel Dodawania
Lewy panel jest odpowiedzialny za dodawanie budynków, pięter, pomieszczeń, przedmiotów i typów przedmiotów. Dla nowych przedmiotów możemy wybrać wcześniej wprowadzony typ jak i istnieje możliwość dodania komentarza.

## Panel Skanowania
Panel na środku to panel w którym możemy skanować kody kreskowe wcześniej wprowadzonych przedmiotów aby stworzyć raport. Przed rozpoczęciem skanowania należy wybrać salę od której zaczynamy inwentaryzację.  

## Panel Dokumentów
Prawy panel jest odpowiedzialny za przeglądanie przeprowadzonych raportów i kodów kreskowych dodanych przedmiotów. W tym panelu istnieje możliwość wyeksportowania ich w formacie gotowym do druku.

<br>

# Ścieżka rozwoju
Nie ma zaplanowanych uaktualnień w najbliższej przyszłości.

<br>

# Licencja
Dystrybuowane pod Licencją MIT. Zobacz `LICENSE` po więcej informacji.

<br>

# Kontakt
Kierownik projektu: Krzysztof Borowski - krzysztofborowski02@gmail.com
<br> 
Link do projektu: https://github.com/Lokinado/flutter_inventory_app
