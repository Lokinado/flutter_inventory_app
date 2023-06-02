// Elementy systemowe
import 'package:flutter/material.dart';
import 'package:list_picker/list_picker.dart';

// Linki do innych plików projekcie
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';
import 'package:inventory_app/database/place_to_list.dart';


class PickPlace extends StatefulWidget {
  @override
  _PickPlaceState createState() => _PickPlaceState();
}

class _PickPlaceState extends State<PickPlace>
    with AutomaticKeepAliveClientMixin<PickPlace> {
  /// Metoda umożliwiająca przechowyanie stanu, na stonach zmienianych paskiem
  /// nawigacyjnym - nadpisuje metode z 'AutomaticKeepAliveClientMixin'
  /// Umożliwia to działanie stron jako niezależnych z zachowaniem stanu między
  /// nimi oddzielnie
  @override
  bool get wantKeepAlive => true;

  /// Kontroler tekstu - umożliwia przekazywanie wyniku z popupów
  final controller = TextEditingController();

  // zmienne i elelementy używane późńiej na stronie

  // !!! funkcje znajdują się na dole stony !!!

  List<List<String>> listaBudynkow = [];
  List<List<String>> listaPieter = [];
  List<List<String>> listaPomieszczen = [];

  List<String> numeryBudynkow = [];
  List<String> numeryPietra = [];
  List<String> numeryPomieszczen = [];


  /// Wybrany budynek
  int budynek = 0;
  late String budynekId;

  /// Wybrane pietro
  var pietro = 0;
  late String pietroId;

  /// Wybrane pomieszczenie
  var pomieszczenie = 0;
  late String pomieszczenieId;


  var zaiZmienPocz = false;

  /// Czy zainicjalizowano zmienne początkowe

  // zmienne przechowywujące rozmiary elementów na stronie
  late double space;
  late double szerokoscPrzycisku;
  double numberBoxSize = 60;

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    /// Pobranie rozmiaru strony przy jej odświezeniu (np. włączenie/wyłączenie
    /// dolnego paska nawigacyjnego)
    final Size rozmiar = MediaQuery.of(context).size;

    /// Przypisanie danych tylko jeden raz
    /// inicjuije dane w tablicach - domyślnie to będzie ich pobranie
    if (!zaiZmienPocz) {
      space = 20;
      inicjalizujBudynki();
      zaiZmienPocz = true;
    }

    /// Ustanienie odstępu w zależności od wielkości strony
    /// (to zmiena się przy reseizie strony - więc musi być poza if wyżej)
    szerokoscPrzycisku = rozmiar.width - 120;

    return Scaffold(
        body: Wrap(
      children: <Widget>[
        TopBodySection(
          key: UniqueKey(),
          tekst: "Skanuj",
          size: rozmiar,
          location: Location.center,
        ),
        Container(
          color: Colors.white,
          child: SizedBox(
            height: rozmiar.height * 0.7,
            width: rozmiar.width,

            ///  Największe pudełko - tutaj jest cała zawartość równo ułożone
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Wszystkie elementy są ułożone tutaj
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  /// Budynek, piętro, pomieszczenie i przycisk
                  children: [
                    /// Wybor budynku
                    Container(
                      margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                      child: Row(
                        children: [
                          /// Zielony kwadracik z wybranym budunkiem
                          Container(
                            alignment: Alignment.center,
                            width: numberBoxSize,
                            height: numberBoxSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(roundness),
                                color: zielonySGGW),
                            child: Text(
                              // Podstawienie wybranego numeru jeśli > 0
                              "${budynek > 0 ? budynek : ""}",
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
                            ),
                          ),

                          /// Przycisk wyboru budynku
                          Container(
                            margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                            width: szerokoscPrzycisku,
                            height: 60.0,
                            child: ElevatedButton(
                              style: leftTextActive,
                              onPressed: () async {
                                String? wyborBudynku = await showPickerDialog(
                                  context: context,
                                  label: "Budynek",
                                  items: numeryBudynkow,
                                );
                                if (wyborBudynku != null) {
                                  var value = int.parse(wyborBudynku.split(" ")[1]);
                                  int index = znajdzNaLiscie(listaBudynkow, wyborBudynku);
                                  budynekId = listaBudynkow[index][1];
                                  setState(() {
                                    if (budynek != value) {
                                      budynek = value;
                                      pietro = 0;
                                      pomieszczenie = 0;
                                    }
                                  });
                                  var tmp = await pobierzPietra(budynekId);
                                  listaPieter = tmp[0];
                                  numeryPietra = tmp[1];
                                }
                              },
                              child: const Text(
                                "Budynek",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Separator
                    separator(space),

                    /// Wybor pietra
                    Container(
                      margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                      child: Row(
                        children: [
                          /// Zielony kwadracik z numerem pietra
                          Container(
                            alignment: Alignment.center,
                            width: numberBoxSize,
                            height: numberBoxSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(roundness),
                                color: budynek != 0
                                    ? zielonySGGW
                                    : zielonySlabaSGGW),
                            child: Text(
                              "${pietro > 0 ? pietro : ""}",
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
                            ),
                          ),

                          /// Przycisk wyboru pietra
                          Container(
                            margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                            width: szerokoscPrzycisku,
                            height: 60.0,
                            child: ElevatedButton(
                              style: budynek != 0
                                  ? leftTextActive
                                  : leftTextNotActive,
                              onPressed: () async {
                                if (budynek != 0) {
                                  String? wyborPietra = await showPickerDialog(
                                    context: context,
                                    label: "",
                                    items: numeryPietra,
                                  );
                                  if (wyborPietra != null) {
                                    var value = int.parse(wyborPietra.split(" ")[1]);
                                    int index = znajdzNaLiscie(listaPieter, wyborPietra);
                                    pietroId = listaPieter[index][1];
                                    setState(() {
                                      if (pietro != value) {
                                        pietro = value;
                                        pomieszczenie = 0;
                                      }
                                    });
                                    await pobierzPomieszczenia(budynekId, pietroId);
                                  }
                                }
                              },
                              child: const Text(
                                "Piętro",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Separator
                    separator(space),

                    /// Wybor pomieszczenia
                    Container(
                      margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                      child: Row(
                        children: [
                          /// Zielony kwadracik z numerem pomieszczenie
                          Container(
                            alignment: Alignment.center,
                            width: numberBoxSize,
                            height: numberBoxSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(roundness),
                                color: pietro != 0
                                    ? zielonySGGW
                                    : zielonySlabaSGGW),
                            child: Text(
                              "${pomieszczenie > 0 ? pomieszczenie : ""}",
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
                            ),
                          ),

                          /// Przycisk wyboru pomieszczenia
                          Container(
                            margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                            width: szerokoscPrzycisku,
                            height: 60.0,
                            child: ElevatedButton(
                              style: pietro != 0 && budynek != 0
                                  ? leftTextActive
                                  : leftTextNotActive,
                              onPressed: () async {
                                if (pietro != 0) {
                                  String? wyborPomieszczenia =
                                      await showPickerDialog(
                                    context: context,
                                    label: "Budynek",
                                    items: numeryPomieszczen,
                                  );
                                  if (wyborPomieszczenia != null) {
                                    setState(() {
                                      pomieszczenie =
                                          int.parse(wyborPomieszczenia);
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                "Pomieszczenie",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Separator
                    separator(4 * space),

                    /// Przycisk rozpoczęcia skanowania
                    SizedBox(
                      width: rozmiar.width - 40,
                      height: 60.0,
                      child: ElevatedButton(
                        style: pietro > 0
                            ? centerTextActive
                            : centerTextNotActive,
                        onPressed: () async {
                          if (pietro > 0) {
                            var wynik =
                                await doSkanowaniaPomieszczenia(context);
                            if (wynik != null) {
                              if (wynik == "reset") {
                                setState(() {
                                  //inicjalizujPusteDane();
                                  budynek = 0;
                                  pietro = 0;
                                  pomieszczenie = 0;
                                });
                              }
                            }
                          }
                        },
                        child: const Text(
                          "Rozpocznij Skanowanie",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }


  /// Separator - element którego jedyną funkcją jest zajmowanie określonej
  /// przestrzeni, w celu rozepchnięcia elementów
  separator(value) => SizedBox(
        height: value,
      );

  /// Funkcja przekierowywująca do skanera
  /// wysyła wygenerowane dane w formie tablic, a także informacje
  /// o obecnie podjętych wyborach co do pomieszczenia
  /// domyślnie, wtedy w skanerze nastąpi pobór danych pomieszczenia
  Future<String?> doSkanowaniaPomieszczenia(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => DemoCamPage(
                budynek: budynek,
                pietro: pietro,
                pomieszczenie: pomieszczenie,
                listaBudynkow: numeryBudynkow,
                listaPieter: numeryPietra,
                listaPomieszczen: numeryPomieszczen,
              )),
    );
    return result;
  }

  /// Dodatkowa funkcja do wywołania funkcji pobierającej listę budynków
  Future inicjalizujBudynki() async {
    List<dynamic> x = await pobierzBudynki();
    listaBudynkow = x[0];
    numeryBudynkow = x[1];
  }
}
