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
  double roundness = 75;

  //  Wymagane by strona została przechowana w pamięci
  @override
  bool get wantKeepAlive => true;

  // Zaokrąglony, Szary, guzik
  var style1 = ElevatedButton.styleFrom(
    minimumSize: const Size(100, 50),
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ));


  @override
  Widget build(BuildContext context) {
    super.build(context); // Wywołuje "AutomaticKeepAliveClientMixin" -> Alive
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
                      SizedBox(
                        width: widget.size.width - 80,
                        height: 60.0,
                        child: ElevatedButton(
                          style: style1,
                          onPressed: () {},
                          child: Text("Uśmiech do kamery", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: widget.size.width - 80,
                        height: 60.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.purple)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CameraPage()),
                            );
                          },
                          child: Text("Uśmiech do kamery"),
                        ),
                      ),
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
