import 'package:flutter/material.dart';
class TopBodySection extends StatelessWidget {
  const TopBodySection({
    required Key key,
    required this.size,
    required this.tekst,
  }) : super(key: key);

  final Size size;
  final String tekst;

  final proportionalHeight = 0.1;

  @override
  Widget build(BuildContext context){
    // It will provide us total height and width of our screen
    return SizedBox(
        height: size.height * proportionalHeight,
        child: Wrap(
          children: [
            Container(
              padding:  EdgeInsets.only(
                left: size.width*0.15,
                bottom: 20,
              ),

              height: size.height * proportionalHeight,
              decoration: const BoxDecoration(
                  //border: Border.all(width: 0),
                color: Color.fromRGBO(0, 50, 39, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(75),
                ),

              ),
              child: Row(
                children: <Widget>[
                  Center( child:
                  Text(tekst, style: TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'Montserrat'),
                  ),)
                ],
              ),
            ),
            /*Container(
              color: const Color.fromRGBO(0, 50, 39, 1),

              child: Positioned(
                top: size.height*0.5,
                left: 0,
                child: Container(
                  width: size.width,
                  height: size.height * proportionalHeight,
                    padding: const EdgeInsets.only(bottom: 0),
                    margin: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.0, color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(75),
                      ),
                    )
                )
              )
            )*/
          ],
        )
    );
  }
}