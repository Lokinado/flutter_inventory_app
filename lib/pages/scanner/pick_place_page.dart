import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/place_choose_button.dart';
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
          tekst: "Skanowanie",
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

  var budynek = 10;
  var pietro = 1;
  var pomieszczenie = 10;
  double numberBoxSize = 60;

  var rozpoczeteSkanowanie = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Zmienne stylistyczne
    var roundness = 20.0;
    double space = 20;
    double space2 = 2 * space;

    // Zaokrąglony, Szary, guzik
    var style1 = ElevatedButton.styleFrom(
        backgroundColor: Colors.white60,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        alignment: Alignment(-0.9, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundness),
        ));

    var style2 = ElevatedButton.styleFrom(
        backgroundColor: Colors.white60,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundness),
        ));

    // Wywołuje "AutomaticKeepAliveClientMixin" -> Alive
    return Container(
        height: widget.size.height * 0.7,
        color: const Color.fromRGBO(0, 50, 39, 1),

        //  Kontener odpowiedzialny za tło z zaokrąglonymi rogami
        child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: Colors.white,

            // Główna zawartość naszej strony
            child: Column(
              children: [
                // Kontener do trzymania zakładek z wybieranim
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    // Budynek, piętro, pomieszczenie
                    children: [
                      // Wybor budynku
                      Container(
                        margin: EdgeInsets.fromLTRB(space2, 0, 0, 0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: numberBoxSize,
                              height: numberBoxSize,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(roundness),
                                  color: Color.fromRGBO(0, 50, 39, 1)),
                              child: Text(
                                "${budynek > 0 ? budynek : ""}",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                            ),
                            SizedBox(
                              width: widget.size.width - 160,
                              height: 60.0,
                              child: ElevatedButton(
                                style: style1,
                                onPressed: () {
                                  setState(() {
                                    budynek = budynek + 1;
                                  });
                                },
                                child: Text(
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
                        margin: EdgeInsets.fromLTRB(space2, 0, 0, 0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: numberBoxSize,
                              height: numberBoxSize,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(roundness),
                                  color: Color.fromRGBO(0, 50, 39, 1)),
                              child: Text(
                                "${pietro > 0 ? pietro : ""}",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                            ),
                            SizedBox(
                              width: widget.size.width - 160,
                              height: 60.0,
                              child: ElevatedButton(
                                style: style1,
                                onPressed: () {
                                  setState(() {
                                    pietro = pietro + 1;
                                  });
                                },
                                child: Text(
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
                        margin: EdgeInsets.fromLTRB(space2, 0, 0, 0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: numberBoxSize,
                              height: numberBoxSize,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(roundness),
                                  color: Color.fromRGBO(0, 50, 39, 1)),
                              child: Text(
                                "${pomieszczenie > 0 ? pomieszczenie : ""}",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                            ),
                            SizedBox(
                              width: widget.size.width - 160,
                              height: 60.0,
                              child: ElevatedButton(
                                style: style1,
                                onPressed: () {
                                  setState(() {
                                    pomieszczenie = pomieszczenie + 1;
                                  });
                                },
                                child: Text(
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
                        height: 140.0,
                      ),

                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                            ),
                            SizedBox(
                              width: widget.size.width - 40,
                              height: 60.0,
                              child: ElevatedButton(
                                style: style2,
                                onPressed: () {
                                  rozpoczeteSkanowanie = true;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CameraPage()),
                                  );
                                },
                                child: Text(
                                  "Rozpocznij Skanowanie",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // Kontener do trzymania przycisków dolnych
                Container(
                  child: Row(
                    // Rozpocznij, zakończ raport
                    children: [],
                  ),
                )
              ],
            )));
  }
}
