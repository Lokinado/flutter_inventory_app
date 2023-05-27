import 'package:flutter/material.dart';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';
import 'dart:math';

import 'package:list_picker/list_picker.dart';

//  ###########################################################################

// Utworzenie głównego ciała strony

//  ###########################################################################

class PickPlace extends StatefulWidget {
  @override
  _PickPlaceState createState() => _PickPlaceState();
}

class _PickPlaceState extends State<PickPlace> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery.of(context).size;

    return Scaffold(
        body: Wrap(
      children: <Widget>[
        TopBodySection(
          key: UniqueKey(),
          tekst: "Skanuj",
          size: rozmiar,
          location: Location.center,
        ),
        PickPlaceContent(
          key: UniqueKey(),
          size: rozmiar,
          location: Location.center,
        )
      ],
    ));
  }
}

//  ###########################################################################

// Wyświetlanie zawartości strony

//  ###########################################################################

@immutable
class PickPlaceContent extends StatefulWidget {
  const PickPlaceContent({Key? key, required this.size, required this.location})
      : super(key: key);

  final Size size;
  final Location location;

  @override
  State<PickPlaceContent> createState() => _PickPlaceContentState();
}

class _PickPlaceContentState extends State<PickPlaceContent>
    with AutomaticKeepAliveClientMixin<PickPlaceContent> {
  //  Wymagane by strona została przechowana w pamięci
  @override
  bool get wantKeepAlive => true;

  //  Zmienne i funkcje niezbędne do tej strony

  var budynek = 0;
  var pietro = 0;
  var pomieszczenie = 0;
  double numberBoxSize = 60;
  var rozpoczeteSkanowanie = false;

  var zielonySGGW = const Color.fromRGBO(0, 50, 39, 1);
  var zielonySlabaSGGW = const Color.fromRGBO(0, 50, 39, 0.5);

  separator(value) => SizedBox(
        height: value,
      );
  final controller = TextEditingController();

  List<String> listaBudynkow = [];
  List<List<String>> pietra = [];
  List<List<List<String>>> pomieszczenia = [];

  void inicjalizujPusteDane() {
    for (int i = 1; i <= 40; i++) {
      listaBudynkow.add(i.toString());
    }

    for (int i = 0; i < listaBudynkow.length; i++) {
      List<String> tmp = [];
      for (int j = 1; j <= 1 + Random().nextInt(2); j++) {
        tmp.add(j.toString());
      }
      pietra.add(tmp);
    }

    for (int i = 0; i < listaBudynkow.length; i++) {
      List<List<String>> bud = [];
      for (int j = 0; j < pietra[i].length + 1; j++) {
        List<String> piet = [];
        for (int p = 1; p <= 10 + Random().nextInt(50); p++) {
          piet.add(p.toString());
        }
        bud.add(piet);
      }
      pomieszczenia.add(bud);
    }
  }

  // Właściwy kod budujący tą stronę

  @override
  Widget build(BuildContext context) {
    // Wywołuje "AutomaticKeepAliveClientMixin" -> Alive
    super.build(context);

    // Zmienne które można zainicjalizować dopiero w konstruktorze
    var roundness = 20.0;
    double space = 20;
    inicjalizujPusteDane();
    var szerokoscPrzycisku = widget.size.width - 120;

    //  "Kontener" wnętrza, ograniczający wysokość całkowitą
    // i ustawiający kolor tła
    return Container(
      color: Colors.white,
      child: SizedBox(
          height: widget.size.height * 0.7,
          width: widget.size.width,

          //  Największe pudełko - tutaj jest cała zawartość równo ułożone
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Wszystkie elementy są ułożone tutaj
              // po co Columna w Columne?
              // Jedna umieszcz an środku "pudełko" (column poniżej)
              // w którym sa już ręcznie rozmieszczonoe elementy
              // (przyciski i separatory z Column poniżej)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,

                // Budynek, piętro, pomieszczenie i przycisk
                children: [
                  // Wybor budynku
                  // Dokładny opis komponentu w place_choose_button.dart
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
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
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                        ),
                        SizedBox(
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

                  // Separator
                  separator(space),

                  // Wybor pietra
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
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
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                        ),
                        SizedBox(
                          width: szerokoscPrzycisku,
                          height: 60.0,
                          child: ElevatedButton(
                            style: budynek != 0
                                ? leftTextActive
                                : leftTextNotActive,
                            onPressed: () async {
                              String? wyborPietra = await showPickerDialog(
                                context: context,
                                label: "",
                                items: pietra[budynek],
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

                  // Separator
                  separator(space),

                  // Wybor pomieszczenia
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
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
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                        ),
                        SizedBox(
                          width: szerokoscPrzycisku,
                          height: 60.0,
                          child: ElevatedButton(
                            style: pietro != 0 && budynek != 0
                                ? leftTextActive
                                : leftTextNotActive,
                            onPressed: () async {
                              String? wyborPomieszczenia =
                                  await showPickerDialog(
                                context: context,
                                label: "Budynek",
                                items: pomieszczenia[budynek][pietro],
                              );
                              if (wyborPomieszczenia != null) {
                                setState(() {
                                  pomieszczenie = int.parse(wyborPomieszczenia);
                                });
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

                  // Separator
                  separator(4 * space),

                  // Przycisk rozpoczęcia skanowania
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    width: widget.size.width - 40,
                    height: 60.0,
                    child: ElevatedButton(
                      style: pomieszczenie > 0
                          ? centerTextActive
                          : centerTextNotActive,
                      onPressed: () {
                        if (pomieszczenie > 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CameraPagePrev()),
                          );
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

              // Kontener do trzymania przycisków dolnych
              //Row( Rozpocznij, zakończ raport children: [],
            ],
          )),
    );
  }
}
