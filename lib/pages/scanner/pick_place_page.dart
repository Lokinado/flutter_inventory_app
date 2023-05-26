import 'package:flutter/material.dart';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';

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

class PickPlaceContent extends StatefulWidget {
  PickPlaceContent({Key? key, required this.size, required this.location})
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

  var budynek = 20;
  var pietro = 20;
  var pomieszczenie = 20;
  double numberBoxSize = 60;

  var zielonySGGW = const Color.fromRGBO(0, 50, 39, 1);

  var rozpoczeteSkanowanie = false;

  @override
  Widget build(BuildContext context) {
    // Wywołuje "AutomaticKeepAliveClientMixin" -> Alive
    super.build(context);

    // Zmienne stylistyczne
    var roundness = 20.0;
    double space = 20;
    double space2 = 2 * space;

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
                            "${budynek > 0 ? budynek : ""}",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                        ),
                        SizedBox(
                          width: widget.size.width - 120,
                          height: 60.0,
                          child: ElevatedButton(
                            style: leftTextActive,
                            onPressed: () {
                              setState(() {
                                budynek = budynek + 1;
                              });
                            },
                            child: const Text(
                              "Budynek",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Separator
                  const SizedBox(
                    height: 20.0,
                  ),

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
                              color: zielonySGGW),
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
                          width: widget.size.width - 120,
                          height: 60.0,
                          child: ElevatedButton(
                            style: budynek > 20
                                ? leftTextActive
                                : leftTextNotActive,
                            onPressed: () {
                              setState(() {
                                if (budynek > 20) {
                                  pietro = pietro + 1;
                                }
                              });
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
                  const SizedBox(
                    height: 20.0,
                  ),

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
                              color: zielonySGGW),
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
                          width: widget.size.width - 120,
                          height: 60.0,
                          child: ElevatedButton(
                            style: pietro > 20
                                ? leftTextActive
                                : leftTextNotActive,
                            onPressed: () {
                              setState(() {
                                if (pietro > 20) {
                                  pomieszczenie = pomieszczenie + 1;
                                }
                              });
                            },
                            child: const Text(
                              "Pomieszczenie",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Separator
                  const SizedBox(
                    height: 100.0,
                  ),

                  // Przycisk rozpoczęcia skanowania
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                      ),
                      SizedBox(
                        width: widget.size.width - 40,
                        height: 60.0,
                        child: ElevatedButton(
                          style: pomieszczenie > 20
                              ? centerTextActive
                              : centerTextNotActive,
                          onPressed: () {
                            if (pomieszczenie > 20) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CameraPage()),
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
                ],
              ),

              // Kontener do trzymania przycisków dolnych
              //Row( Rozpocznij, zakończ raport children: [],
            ],
          )),
    );
  }
}
