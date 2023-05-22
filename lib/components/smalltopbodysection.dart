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
        child: Stack(
          children: <Widget>[
            Container(
              padding:  EdgeInsets.only(
                left: size.width*0.15,
                bottom: 20,
              ),
              height: size.height * proportionalHeight,
              decoration:
              const BoxDecoration(
                color: Color.fromRGBO(0, 50, 39, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(75),
                  bottomRight: Radius.circular(75)
                ),
              ),
              child: Row(
                children: <Widget>[
                  Center( child: Text(
                    this.tekst,
                    style: TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'Montserrat'),
                  ),)
                ],
              ),
            ),
          ],
        )
    );
  }
}