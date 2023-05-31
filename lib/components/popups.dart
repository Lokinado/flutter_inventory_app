import 'package:flutter/material.dart';

const TextStyle czerwonyTekst = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.w500,
);

const TextStyle zielonyTekst = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w500,
);

const TextStyle niebieskiTekst = TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.w500,
);

/// Popup, który upewnia się, że użytkownik chce porzucić wprowadzone zmiany
/// przekazujemy mu kontekst i infromacje o tytule i wyświetlanym komunikacie
/// możemy też opcjonalnie przekazać informacje o formatowaniu przycisków
Future confirmAction(context, String title, String text, TextStyle formatTitle,
        TextStyle formatInfo, formatYesB, TextStyle formatNoB) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: formatTitle),
        content: Text(text),
        actions: [
          TextButton(
            child: Text(
              "Tak",
              style: formatYesB,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: Text(
              "Nie",
              style: formatNoB,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

/// Tak jak confirmAction ale przyciski potwierdzenia i odrzucenia, zamienione
/// miejscami
Future confirmActionRev(context, String title, String text, TextStyle formatTitle,
    TextStyle formatInfo, formatYesB, TextStyle formatNoB) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: formatTitle),
        content: Text(text),
        actions: [
          TextButton(
            child: Text(
              "Nie",
              style: formatNoB,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Tak",
              style: formatYesB,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
