import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/place_choose_button.dart';

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
                  child: Column(
                    // Budynek, piętro, pomieszczenie
                    children: [],
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
