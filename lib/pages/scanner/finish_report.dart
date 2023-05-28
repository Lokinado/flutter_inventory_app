import 'package:flutter/material.dart';

class FinishReportPage extends StatefulWidget {
  const FinishReportPage({Key? key}) : super(key: key);

  @override
  State<FinishReportPage> createState() => _FinishReportPageState();
}

class _FinishReportPageState extends State<FinishReportPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textEditingController;


  @override
  Widget build(BuildContext context) {

    // Pobranie informacji nt. wymiarów okna
    final Size rozmiar = MediaQuery.of(context).size;

    // Przygotowanie zmiennenych pomodniczych do rozmiarowania elementów
    double textHeighOffset = rozmiar.height * 0.04;
    double elementsOffset = rozmiar.height * 0.023;


    return Scaffold(

      /// Nagłówek aplikacji
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        toolbarHeight: textHeighOffset * 3,
        centerTitle: true,
        title: const Text(
          "Zakończ skanowanie",
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
