import 'package:flutter/material.dart';
import 'dart:math';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:list_picker/list_picker.dart';

class ChangePlacePage extends StatefulWidget {
  const ChangePlacePage({
    Key? key,
    required this.budynek,
    required this.pietro,
    required this.pomieszczenie,
    required this.listaBudynkow,
    required this.listaPieter,
    required this.listaPomieszczen,
  }) : super(key: key);

  final budynek;
  final pietro;
  final pomieszczenie;
  final List<String> listaBudynkow;
  final List<List<String>> listaPieter;
  final List<List<List<String>>> listaPomieszczen;

  @override
  State<ChangePlacePage> createState() => _ChangePlacePageState();
}

class _ChangePlacePageState extends State<ChangePlacePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textEditingController;

  var budynek = 0;
  var pietro = 0;
  var pomieszczenie = 0;

  double numberBoxSize = 60;

  var powrot = false;

  separator(value) => SizedBox(
        height: value,
      );

  final controller = TextEditingController();

  var dummyVariable = true;

  @override
  Widget build(BuildContext context) {
    // Pobranie informacji nt. wymiarów okna
    final Size rozmiar = MediaQuery.of(context).size;

    if (dummyVariable){
      budynek = widget.budynek;
      pietro = widget.pietro;
      pomieszczenie = widget.pomieszczenie;
      dummyVariable = false;
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
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
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
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            "${budynek > 0 ? budynek : ""}",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                        // Pusty separator

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
                                label: "budynek",
                                items: widget.listaBudynkow,
                              );
                              if (wyborBudynku != null) {
                                var value = int.parse(wyborBudynku);
                                setState(() {
                                  if (budynek != value) {
                                    budynek = value;
                                    pietro = 0;
                                    pomieszczenie = 0;
                                  }
                                });
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
                              color: budynek != 0
                                  ? zielonySGGW
                                  : zielonySlabaSGGW),
                          child: Text(
                            "${pietro > 0 ? pietro : ""}",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),

                        /// Przycisk wyboru piętra
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
                                  label: "piętro",
                                  items: widget.listaPieter[budynek],
                                );
                                if (wyborPietra != null) {
                                  var value = int.parse(wyborPietra);
                                  setState(() {
                                    if (pietro != value) {
                                      pietro = value;
                                      pomieszczenie = 0;
                                    }
                                  });
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
                                  pietro != 0 ? zielonySGGW : zielonySlabaSGGW),
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
                                  label: "pomieszczenie",
                                  items: widget.listaPomieszczen[budynek][pietro],
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
                ],
              ),

              /// Dolne przyciski do sterowania
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      confirmExit();
                    },
                    child: Container(
                      height: elementsOffset * 4,
                      width: rozmiar.width * 0.33,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(245, 123, 107, 1),
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
                  GestureDetector(
                    onTap: () {
                      if (pomieszczenie > 0) {
                        Navigator.of(context)
                            .pop([budynek, pietro, pomieszczenie]);
                      }
                    },
                    child: Container(
                      height: elementsOffset * 4,
                      width: rozmiar.width * 0.53,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pomieszczenie > 0
                            ? Colors.green
                            : Colors.green.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Zmiana",
                        style: TextStyle(
                            fontSize: elementsOffset * 1.2,
                            color: pomieszczenie > 0
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
    _controller = AnimationController(vsync: this);
  }

  /// Usuwanie stanu ekranu po wyjściu
  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  /// Popup, który upewnia się, że użytkownik chce porzucić wprowadzone zmiany
  Future confirmExit() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Ostrzeżenie"),
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
