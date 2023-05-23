import 'package:flutter/material.dart';

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
  final String tekst;
  final proportionalHeight = 0.1;
  double roundness = 75;

  Location location;
  final bool curveReverse;

  double leftRoundness = 0;
  double rightRoundness = 0;
  double proportion = 0.18;

  @override
  Widget build(BuildContext context) {
    if (curveReverse) {
      if (location == Location.left) {
        location = Location.right;
      } else if (location == Location.right) {
        location = Location.left;
      }
    }

    if (location == Location.center) {
      leftRoundness = roundness;
      rightRoundness = roundness;
      proportion = 0.26;
    } else if (location == Location.right) {
      leftRoundness = roundness;
    } else {
      rightRoundness = roundness;
    }

    return SizedBox(
      height: size.height * proportionalHeight,
      child: Column(
        children: [
          Container(
            height: size.height * proportionalHeight,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 50, 39, 1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(rightRoundness),
                bottomLeft: Radius.circular(leftRoundness),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * proportion,
                right: size.width * proportion,
                top: 20, // Dodane wcięcie na górze
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    tekst,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}