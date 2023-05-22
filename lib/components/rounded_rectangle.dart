import 'package:flutter/material.dart';

class roundedRectangleTextBox extends StatelessWidget {
  final String text;
  final double top;
  final double right;
  final double width;

  const roundedRectangleTextBox({
    Key? key,
    required this.text,
    required this.top,
    required this.right,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCircle(
      text: text,
      top: top,
      right: right,
      width: width,
    );
  }

  Widget buildCircle({
    required String text,
    required double top,
    required double right,
    required double width,
  }) {
    return Positioned(
      top: top,
      right: right,
      child: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 50, 39, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: width,
              height: width / 6,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class roundedRectangleButton extends StatelessWidget {
  final String napis;
  final double top;
  final double right;
  final double width;
  var destination;

  roundedRectangleButton({
    Key? key,
    required this.destination,
    required this.napis,
    required this.top,
    required this.right,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCircle(
      context: context,
      destination: destination,
      napis: napis,
      top: top,
      right: right,
      width: width,
    );
  }

  Widget buildCircle({
    required context,
    required destination,
    required String napis,
    required double top,
    required double right,
    required double width,
  }) {
    return  Positioned(
      top: top,
      right: right,
      child: SizedBox(
        width: 382,
        height: 70,
        child: ElevatedButton(
          onPressed: (){
            Navigator.push( context,
              MaterialPageRoute(builder: (context) => destination), );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(228, 6, 139, 57),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),  child: Text(
          napis.toString(), style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold, fontSize: 25,
        ),
        ),
        ),
      ),
    );
  }
}

