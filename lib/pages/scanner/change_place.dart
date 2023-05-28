import 'package:flutter/material.dart';
import 'dart:math';

class ChangePlacePage extends StatefulWidget {
  const ChangePlacePage({Key? key}) : super(key: key);

  @override
  State<ChangePlacePage> createState() => _ChangePlacePageState();
}

class _ChangePlacePageState extends State<ChangePlacePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textEditingController;

  /// Zmienne przechowywujące informacje nt. przedmiotów do skanownaia
  List<List<dynamic>> biurka = [];
  List<List<dynamic>> monitory = [];
  List<List<dynamic>> krzesla = [];

  /// Zmienne do późńiejszego zainicjowania
  late int liczbaBiurek;
  late int liczbaMonitorow;
  late int liczbaKrzesel;

  @override
  Widget build(BuildContext context) {

    // Pobranie informacji nt. wymiarów okna
    final Size rozmiar = MediaQuery.of(context).size;

    // Przygotowanie zmiennenych pomodniczych do rozmiarowania elementów
    double textHeighOffset = rozmiar.height * 0.04;
    double elementsOffset = rozmiar.height * 0.023;



    // Przechowuje informacje o ostatnim zeskanowanym elemencie
    var scannedValue = krzesla[1][1].toString();


    return Scaffold(

      /// Nagłówek aplikacji
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        toolbarHeight: textHeighOffset * 3,
        centerTitle: true,
        title: const Text(
          "Zmiana Pomieszczenia",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(34),
            bottomRight: Radius.circular(34),
          ),
        ),
      ),

      /// Zawartość ciała

    );
  }

  /// Początkowa inicjalizacja ekranu
  @override
  void initState() {
    super.initState();
    losuj();
    _textEditingController = TextEditingController();
    _controller = AnimationController(vsync: this);
  }

  /// Usuwanie stanu ekranu po wyjściu
  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  /// Metoda tymczasowa - generowanie danych do testów
  void losuj() {
    for (int i = 1; i <= 20; i++) {
      List<dynamic> tmp = [];
      tmp.add("Biurko $i");
      tmp.add(Random().hashCode.toString());
      tmp.add(false);
      tmp.add("");
      biurka.add(tmp);
    }

    for (int i = 1; i <= 20; i++) {
      List<dynamic> tmp = [];
      tmp.add("Monitor $i");
      tmp.add(Random().hashCode.toString());
      tmp.add(false);
      tmp.add("");
      monitory.add(tmp);
    }

    for (int i = 1; i <= 20; i++) {
      List<dynamic> tmp = [];
      tmp.add("Krzeslo $i");
      tmp.add(Random().hashCode.toString());
      tmp.add(false);
      tmp.add("");
      krzesla.add(tmp);
    }
  }


  /// Okienko do wyświetlania popupu do dodania komentarza
  Future openDialog(naglowek) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(naglowek),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: "Wprowadź komentarz"),
          controller: _textEditingController,
        ),
        actions: [
          TextButton(
            child: const Text("Dodaj komentarz"),
            onPressed: () {
              Navigator.of(context).pop(_textEditingController.text);
            },
          )
        ],
      ));

}
