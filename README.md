<!--
+++
author = "Józef Stocki"
title = "Flutter Inventory App"
date = "2023-06-13"
description = "The application for conducting the inventory process."
summary = "The application for conducting the inventory process."
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
    The application for conducting the inventory process
    <br />
    <!--
    <a href="DEMO LINK"><strong>View Demo»</strong></a>
    -->
  </p>
</p>

<br><br>

# About The Project
An inventory-taking application created upon request. Fixed assets in rooms are identified by a number recorded on a sticker and represented by a barcode. There is the possibility to differentiate between buildings, with multiple floors in each building, and multiple rooms on each floor.

[Github Repo](https://github.com/Lokinado/flutter_inventory_app)

![Image of application interface](https://raw.githubusercontent.com/Lokinado/flutter_inventory_app/main/Images/img.png "Interface!")

<br>

## Team
| **Project Manager** |
|:----------------------:|
|   [Krzysztof Borowski](https://github.com/Lokinado)   |

| **Lead Developer** | **Lead Tester** |  **Lead Writer**  |
|:------------------:|:---------------:|:-----------------:|
|    [Jeremi Lipiec](https://github.com/JeremiLipiec)   |  [Maciej Sieradz](https://github.com/MaciejSieradz) | Filip Sapiejewski |

|    **Developer**    |    **Tester**    |   **Writer**   |
|:-------------------:|:----------------:|:--------------:|
|     [Piotr Bauer](https://github.com/Bauero)     |  Jakub Dąbrowski |  Jakub Dolecki |
|   [Adam Ciesielski](https://github.com/AdamCI3)   |    [Jakub Litke](https://github.com/Litas0)   |  Szymon Boruń  |
| [Wojciech Sokołowski](https://github.com/Sokulele) |     Kasia Sak    |  Patryk Jeleń  |
|   [Arkadiusz Affek](https://github.com/ArekAff)   |     Sara Stec    | Konrad Bolesta |
|      [Jan Dusza](https://github.com/J-Dusza)      | [Piotr Chodkowski](https://github.com/piochod) | Piotr Majewski |
|    [Dawid Steciuk](https://github.com/Szyno9)    |   [Józef Stocki](https://github.com/4Maksio)   |                |

## Functionalities
- Scanning barcodes with a camera
- Manual entry of barcodes
- Reporting individual rooms
- Validation of item placement

<br>

## Build With
The most noteworthy frameworks and technologies.
* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
* [Firebase](https://firebase.google.com/)

<br>

# Getting Started

<br>

## Prerequisites
* Dart SDK [Dart SDK Installation Page](https://dart.dev/get-dart)
* Flutter SDK [Flutter SDK Installation Page](https://docs.flutter.dev/get-started/install)
* Android studio [Android studio Installation Page](https://docs.flutter.dev/get-started/install)

<br>

## Clone the repo
1. Sklonuj repozytorium
```sh
git clone https://github.com/Lokinado/flutter_inventory_app
```
2. Open the terminal in the main project directory and build the application using Flutter CLI
```sh
flutter build apk --split-per-abi
```
3. The generated .apk file is ready to be installed on any Android phone

<br>

# Usage
The application structure is divided into 3 main screens

## Addition Panel
The left panel is responsible for adding buildings, floors, rooms, items, and item types. For new items, we can choose a pre-entered type or add a comment if needed.

## Scanner Panel
The middle panel is where we can scan barcodes of pre-entered items to generate a report. Before starting the scanning process, it is necessary to select the room from which we begin the inventory.

## Documents Panel
The right panel is responsible for reviewing conducted reports and barcodes of added items. In this panel, there is an option to export them in a print-ready format.

<br>

# Roadmap
No updates are planned in the near future.

<br>

# Licence
Distributed under the MIT License. See `LICENSE` for more information.

<br>

# Contact
Project manager: Krzysztof Borowski - krzysztofborowski02@gmail.com
<br> 
Project Link: https://github.com/Lokinado/flutter_inventory_app
