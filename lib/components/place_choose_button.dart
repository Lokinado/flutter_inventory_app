import 'package:flutter/material.dart';

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
  var choosenValue = 0;
  var value = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(widget.locationHorizontally, widget.locationVertically),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            value = value+1;
          });
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
