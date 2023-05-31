import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';

/// Lista możliwych ułożeń strony
enum Location { left, center, right }

class TopBodySection extends StatelessWidget {
  TopBodySection({
    required Key key,
    required this.size,
    required this.tekst,
    required this.location,
    this.curveReverse = false,
  }) : super(key: key);

  final Size size;

  /// Zmienna trzymająca rozmiar strony
  final String tekst;

  /// Zmienna trzymająca tekst który ma być wyświetlony
  final proportionalHeight = 0.1;

  /// Proporcja
  double roundness = 75;

  /// Siła zaokrąglenia

  Location location;

  /// zmienna przechowywująca wybraną opcję zaokrąblenia
  final bool curveReverse;

  /// Czy odwrócić zaokrąglanie

  //  Setting the foundness of the box
  double leftRoundness = 0;
  double rightRoundness = 0;
  double proportion = 0.18;

  var alignment;

  @override
  Widget build(BuildContext context) {
    /// Odrórcenie wartości, jeśli curveReverse = true
    if (curveReverse) {
      if (location == Location.left) {
        location = Location.right;
      }
      if (location == Location.right) {
        location = Location.left;
      }
    }

    /// Odpowiednie ustawienei wartosci elementów ze względnu na 'location'
    if (location == Location.center) {
      leftRoundness = roundness;
      rightRoundness = roundness;
      proportion = 0.26;
      alignment = Alignment.center;
    } else if (location == Location.right) {
      leftRoundness = roundness;
      alignment = Alignment.centerLeft;
    } else {
      rightRoundness = roundness;
      alignment = Alignment.centerLeft;
    }

    /// Zwrócenie gotowego nagłówka
    return Container(
      color: Colors.white, // kolor który widać na zaokrąglonych rogach
      child: SizedBox(
          height: size.height * proportionalHeight,
          child: Column(
            children: [
              /// Zielony zaokrąglony kontenrer
              Container(
                width: size.width,
                padding: EdgeInsets.only(
                  left: size.width * proportion,
                  right: size.width * proportion,
                  bottom: 20,
                ),
                height: size.height * proportionalHeight,
                decoration: BoxDecoration(
                  color: zielonySGGW,
                  borderRadius: BorderRadius.only(
                    //  Roundness is on the opposite site
                    bottomRight: Radius.circular(rightRoundness),
                    bottomLeft: Radius.circular(leftRoundness),
                  ),
                ),
                child:

                /// Wyświetlany tekst nagłówka
                Container(
                  alignment: alignment,
                  child: Text(
                    tekst,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
