import 'package:flutter/material.dart';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:list_picker/list_picker.dart';
import 'package:inventory_app/database/place_to_list.dart';

class ChangePlacePage extends StatefulWidget {
  const ChangePlacePage({
    Key? key,
    required this.budynek,
    required this.pietro,
    required this.pomieszczenie,
  }) : super(key: key);

  final String budynek;
  final String pietro;
  final String pomieszczenie;

  @override
  State<ChangePlacePage> createState() => _ChangePlacePageState();
}

class _ChangePlacePageState extends State<ChangePlacePage> {

  double numberBoxSize = 60; /// Zmienna stylistyczna - wysokość pól wyboru

  /// Przechowuje rezultat wyskakujacych popupowych okienek
  late TextEditingController _textEditingController;

  late String budynek; /// Wybrany przez użytkownika budynek
  late String pietro; /// Wybrane przez użytkownika pietro
  late String pomieszczenie; /// Wybrane przez użytkownika pomieszczenie

  List<String> listaBudynkow = [];
  List<String> listaPieter = [];
  List<String> listaPomieszczen = [];

  var inicjalizujDane = true; /// Utworzeni / pobranie danych do / z bazy

  @override
  Widget build(BuildContext context) {
    // Pobranie informacji nt. wymiarów okna
    final Size rozmiar = MediaQuery.of(context).size;

    if (inicjalizujDane){
      budynek = widget.budynek;
      pietro = widget.pietro;
      pomieszczenie = widget.pomieszczenie;

      inicjalizujDane = false;
    }

    // Przygotowanie zmiennenych pomodniczych do rozmiarowania elementów
    double textHeighOffset = rozmiar.height * 0.04;
    double elementsOffset = rozmiar.height * 0.023;

    /// Zmienne które można zainicjalizować dopiero w konstruktorze
    double space = 20;
    var szerokoscPrzycisku = rozmiar.width - 120;

    return Scaffold(
      /// Nagłówek aplikacji
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: zielonySGGW,
        toolbarHeight: textHeighOffset * 3,
        centerTitle: true,
        title: const Text(
          "Zmiana Pomieszczenia",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(34),
            bottomRight: Radius.circular(34),
          ),
        ),
      ),

      /// Zawartość ciała
      body: Container(
        color: Colors.white,
        child: SizedBox(
          height: rozmiar.height,
          width: rozmiar.width,

          ///  Największe pudełko - tutaj jest cała zawartość równo ułożone
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// Wszystkie elementy są ułożone tutaj
              const SizedBox(
                height: 10,
              ),

              /// Budynek, piętro, pomieszczenie i przycisk
              Column(
                children: [
                  /// Wybor budynku
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      children: [
                        /// Wybrany budynek
                        Container(
                          alignment: Alignment.center,
                          width: numberBoxSize,
                          height: numberBoxSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(roundness),
                              color: zielonySGGW),
                          child: Text(
                            // Podstawienie wybranego numeru jeśli > 0
                            budynek,
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                        // Pusty separator

                        /// Przycisk wyboru budynku
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                          width: szerokoscPrzycisku,
                          height: numberBoxSize,
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

                  /// Separator
                  separator(space),

                  /// Wybor pietra
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      children: [
                        /// Wybrane Piętro
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

                        /// Przycisk wyboru piętra
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                          width: szerokoscPrzycisku,
                          height: numberBoxSize,
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
                        /// Wybrane pomieszczenie
                        Container(
                          alignment: Alignment.center,
                          width: numberBoxSize,
                          height: numberBoxSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(roundness),
                              color:
                                  pietro != "" ? zielonySGGW : zielonySlabaSGGW),
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
                          height: numberBoxSize,
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
                ],
              ),

              /// Dolne przyciski do sterowania
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  /// Podłączony przycisk odrzucenia zmian
                  GestureDetector(
                    onTap: () {
                      confirmExit();
                    },
                    child: Container(
                      height: elementsOffset * 4,
                      width: rozmiar.width * 0.33,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: lososiowyCzerwony,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Anuluj",
                        style: TextStyle(
                            fontSize: elementsOffset * 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  /// Podłączony przycisk zatwierdzenia zmiany pomieszczenia
                  GestureDetector(
                    onTap: () {
                      if (pomieszczenie != "") {
                        Navigator.of(context)
                            .pop([budynek, pietro, pomieszczenie]);
                      }
                    },
                    child: Container(
                      height: elementsOffset * 4,
                      width: rozmiar.width * 0.53,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pomieszczenie != ""
                            ? Colors.green
                            : Colors.green.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Zmiana",
                        style: TextStyle(
                            fontSize: elementsOffset * 1.2,
                            color: pomieszczenie != ""
                                ? Colors.black
                                : Colors.black.withOpacity(0.4),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Początkowa inicjalizacja ekranu
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    pobierzDane();
  }

  /// Usuwanie stanu ekranu po wyjściu
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  /// Zaciąga dane z bazy nt. list dla kolejnych wyborów
  Future pobierzDane() async {
    listaBudynkow = await pobierzBudynki();
    listaPieter = await pobierzPietra(widget.budynek);
    listaPomieszczen = await pobierzPomieszczenia(widget.budynek, widget.pietro);
  }

  separator(value) => SizedBox( height: value, );

  /// Popup, który upewnia się, że użytkownik chce porzucić wprowadzone zmiany
  Future confirmExit() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Ostrzeżenie"),
          content: const Text("Czy chcesz wyjść bez zmiany pomieszczenia?"),
          actions: [
            TextButton(
              child: const Text(
                "Tak",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Nie"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
