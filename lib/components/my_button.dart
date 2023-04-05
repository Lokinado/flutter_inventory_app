import 'package:flutter/material.dart';

class MyButton extends StatelessWidget { //to create a button
  
  final Function()? onTap; //to add an action to the button
  
  const MyButton({super.key, required this.onTap}); //constructor

  @override
  Widget build(BuildContext context) { //to build the button
    return GestureDetector(
      onTap: onTap, //to add an action to the button
      child: Container( //to create a container
        padding: const EdgeInsets.all(25), //to add space between the text and the border
        margin:  const EdgeInsets.symmetric(horizontal: 25), //to add space between the button and the border
        decoration: BoxDecoration( //to add decoration to the button
          color: Colors.black, 
          borderRadius: BorderRadius.circular(8), //to make the corners of the button rounded
        ),
        child:  const Center( //to center the text
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}