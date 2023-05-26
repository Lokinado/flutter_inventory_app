import 'package:flutter/material.dart';
import 'package:inventory_app/components/element_styling.dart';

/*
  Wybrany numer           Przycisk do aktywacji

    .^.::::::::::::^       ~.:::::::::::::::::::::::::::::::::::::::::::::.^:
    .^             ~      .~                                               :^
    .^  .::  .::.  ~      .~                                               :^
    .^   :: ::  :: ~      .~                                               :^
    .^   ::  `::`  ~      .~                                               :^
    .^             ~      .~                                               :^
    .^.::::::::::::^       ~.:::::::::::::::::::::::::::::::::::::::::::::.^:

*/

@immutable
class PlaceButton extends StatefulWidget {
  const PlaceButton({Key? key,
    required this.size,
    required this.gboxWidth,
    required this.buttonWidht,
    required this.height,
    required this.onTap
  }) : super(key: key);


  // To są potrzebne parametry - są one specyficzne dla konkretnych użyć
  final Size size;            // Rozmiar dostępnej przestrzeni
  final double gboxWidth;            // Bok zieloneg kwadratu na wybraną wartość
  final double buttonWidht;          // Szerokość samego guzika
  final double height;               // Wysookość elementów (guzik i kwadracik)
  final Function()? onTap;


  @override
  State<PlaceButton> createState() => _PlaceButtonState();
}

class _PlaceButtonState extends State<PlaceButton>
    with AutomaticKeepAliveClientMixin<PlaceButton>{

  // Jest to wybrana wartość kóra jest przechowywana w naszym programie, w
  // zielonym guziku
  // w programie jest to np. zmienna "pomieszczenie"
  var internalValue = 10;
  var zielonySGGW = const Color.fromRGBO(0, 50, 39, 1);

  // Nadpisanie zmiennej odpowiedzialnej za przechowywanie stanu elementu
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Są to zmienne bezpośrednio modyfikujące wygląd naszego elementu,
    // roundness odpowiada za krzywiznę rogów
    // a space odpowiada za
    roundness = 20;
    double space = 20;

    return Container(

      // Lewy margines umożliwiający ładny spacing przycisku
      margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
      child: Row(
        children: [

          // Kolory kwadracik do przechowywania wartości
          Container(
            alignment: Alignment.center,
            width: widget.gboxWidth,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundness),
                color: zielonySGGW),
            child: Text(
              "${internalValue > 0 ? internalValue : ""}",
              style: const TextStyle(
                  fontSize: 22, color: Colors.white),
            ),
          ),

          // Pusty separator między kwadracikiem a przyciskiem
          Container(
            margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
          ),

          // Przycisk o konkretnych wymiarach
          SizedBox(
            width: widget.size.width - 120,
            height: 60.0,
            child: ElevatedButton(
              style: leftTextActive,
              onPressed: () {
                setState(() {
                  internalValue = internalValue + 1;
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
    );
  }
}