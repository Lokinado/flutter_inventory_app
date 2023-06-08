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

  List<String> listaBudynkow = [];
  List<String> listaPieter = [];
  List<String> listaPomieszczen = [];


  /// Wybrany budynek
  String budynek = "";

  /// Wybrane pietro
  String pietro  = "";

  /// Wybrane pomieszczenie
  String pomieszczenie = "";

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
                              budynek,
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
                                  items: listaBudynkow,
                                );
                                if (wyborBudynku != null) {
                                  setState(() {
                                    // wybrano wartość inną niż wpisana => reset
                                    if (budynek != wyborBudynku) {
                                      budynek = wyborBudynku;
                                      pietro = "";
                                      pomieszczenie = "";
                                    }
                                  });
                                  listaPieter = await pobierzPietra(budynek);
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
                                color: budynek != ""
                                    ? zielonySGGW
                                    : zielonySlabaSGGW),
                            child: Text(
                              pietro,
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
                              style: budynek != ""
                                  ? leftTextActive
                                  : leftTextNotActive,
                              onPressed: () async {
                                if (budynek != "") {
                                  String? wyborPietra = await showPickerDialog(
                                    context: context,
                                    label: "Piętro",
                                    items: listaPieter,
                                  );
                                  if (wyborPietra != null) {
                                    setState(() {
                                      // wybrano wartość inną niż wpisana => reset
                                      if (pietro != wyborPietra) {
                                        pietro = wyborPietra;
                                        pomieszczenie = "";
                                      }
                                    });
                                    listaPomieszczen = await pobierzPomieszczenia(budynek, pietro);
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
                                color: pietro != ""
                                    ? zielonySGGW
                                    : zielonySlabaSGGW),
                            child: Text(
                              pomieszczenie,
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
                              style: pietro != "" && budynek != ""
                                  ? leftTextActive
                                  : leftTextNotActive,
                              onPressed: () async {
                                if (pietro != "") {
                                  String? wyborPomieszczenia =
                                      await showPickerDialog(
                                    context: context,
                                    label: "Pomieszczenie",
                                    items: listaPomieszczen,
                                  );
                                  if (wyborPomieszczenia != null) {
                                    setState(() {
                                      // wybrano wartość inną niż wpisana => reset
                                      if (pomieszczenie != wyborPomieszczenia) {
                                        pomieszczenie = wyborPomieszczenia;
                                      }
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
                        style: pietro != ""
                            ? centerTextActive
                            : centerTextNotActive,
                        onPressed: () async {
                          if (pietro != "") {
                            var wynik =
                                await doSkanowaniaPomieszczenia(context);
                            if (wynik != null) {
                              if (wynik == "reset") {
                                setState(() {
                                  //inicjalizujPusteDane();
                                  budynek = "";
                                  pietro = "";
                                  pomieszczenie = "";
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
                listaBudynkow: listaBudynkow,
                listaPieter: listaPieter,
                listaPomieszczen: listaPomieszczen,
              )),
    );
    return result;
  }

  /// Dodatkowa funkcja do wywołania funkcji pobierającej listę budynków
  Future inicjalizujBudynki() async {
    listaBudynkow = await pobierzBudynki();
  }
}
