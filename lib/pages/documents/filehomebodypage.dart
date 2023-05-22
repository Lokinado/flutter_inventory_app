import 'package:flutter/material.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/rounded_rectangle.dart';

class CenterFileHomePage extends StatelessWidget {
   CenterFileHomePage({Key? key,
    required this.size,
    required this.location})
      : super(key: key);

  final Size size;
  final Location location;
  double roundness = 75;


  @override
  Widget build(BuildContext context) {
    var elemWidth = size.width*0.9;
    return Container(
      height: size.height*0.7,
      color: const Color.fromRGBO(0, 50, 39, 1),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
                location == Location.right? roundness : 0),
            topLeft: Radius.circular(
                location == Location.left? roundness : 0),
          ),
        ),
        child: Stack(
          children: <Widget>[
            //roundedRectangleTextBox(text: '${34}     |     Budynek', top: 110, right: 5, width: elemWidth),
            //roundedRectangleTextBox(text: '${3}     |     Piętro', top: 190, right: 5,  width: elemWidth),
            //roundedRectangleTextBox(text: '${32}      |     Pomieszczenie', top: 270, right: 5,  width: elemWidth),
            //roundedRectangleButton(destination: CameraPage(), top: 410, right: 5, width: elemWidth, napis: "Coś nowego",),
            
          ],
        ),
      )
    );

  }
}
