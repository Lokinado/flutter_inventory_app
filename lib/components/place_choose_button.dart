import 'package:flutter/material.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';

class PlaceButton extends StatefulWidget {
  PlaceButton({Key? key,
    required this.onTap,
    required this.locationVertically,
    required this.locationHorizontally
  }) : super(key: key);

  final locationVertically;
  final locationHorizontally;
  final Function()? onTap;


  @override
  State<PlaceButton> createState() => _PlaceButtonState();
}

class _PlaceButtonState extends State<PlaceButton> {
  var chosenValue = 0;
  var value = 1;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(widget.locationHorizontally, widget.locationVertically),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),

      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CameraPage()),
          );
        },

        child: Text('Sum = ${value}'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

        ),
      ),
    );
  }
}