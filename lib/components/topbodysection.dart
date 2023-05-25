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

   // Main parameters of the interface
  final Size size;
  final String tekst;
  final proportionalHeight = 0.1;
  double roundness = 75;
  
  Location location;
  // if the roundness should be reversed
  final bool curveReverse;

  //  Setting the foundness of the box
  double leftRoundness = 0;
  double rightRoundness = 0;
  double proportion = 0.18;

  @override
  Widget build(BuildContext context){

    if (curveReverse){
      if (location == Location.left) { location = Location.right; }
      if (location == Location.right) {location = Location.left; }
    }

    //  Adjusting the top pannel depending on the screen
    if (location == Location.center)
    {
      leftRoundness = roundness;
      rightRoundness = roundness;
      proportion = 0.26;
    }
    else if (location == Location.right)
      { leftRoundness = roundness; }
    else
      { rightRoundness = roundness; }


    // It will provide us total height and width of our screen
    return SizedBox(
        height: size.height * proportionalHeight,
        child: Column(
          children: [
            Container(
              padding:  EdgeInsets.only(
                left: size.width*proportion,
                bottom: 20,
              ),
              height: size.height * proportionalHeight,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 50, 39, 1),
                borderRadius: BorderRadius.only(
                  //  Roundness is on the opposite site
                  bottomRight: Radius.circular(rightRoundness),
                  bottomLeft: Radius.circular(leftRoundness),
                ),

              ),
              child: Row(
                children: <Widget>[Text(tekst, style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'Montserrat',)
                  ,)
                ],
              ),
            ),
          ],
        )
    );
  }
}