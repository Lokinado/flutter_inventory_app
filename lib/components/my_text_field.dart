import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });


  @override
  Widget build(BuildContext context){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0), //to add space between the textfield and the border
        child: TextField( //to create a textfield
          controller: controller, //to get what to user typed in the textfield
          obscureText: obscureText, //to hide the text for example when typing a password
          decoration: InputDecoration( //to add decoration to the textfield
            enabledBorder: const OutlineInputBorder( //to change the border color
              borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder( //to change the border color when the textfield is focused
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200, // color filling the textfield
              filled: true,
              hintText: hintText, //to hint to the user what to type in the textfield
              hintStyle: TextStyle(color: Colors.grey[500])
              ),
            ),
        );
  }
}