import 'package:flutter/material.dart';


/// Popup, który upewnia się, że użytkownik chce porzucić wprowadzone zmiany
Future confirmExit(context, String title, String text) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      TextButton(
        child: const Text(
          "Tak",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      TextButton(
        child: const Text("Nie"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);