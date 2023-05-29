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
        automaticallyImplyLeading: false,
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
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: rozmiar.height*0.6,
              width: rozmiar.width,
              alignment: Alignment.center,
              child: Container(
                height: rozmiar.height*0.53,
                width: rozmiar.width*0.9,
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Text("Tutaj będzie raport"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: elementsOffset * 4,
                width: rozmiar.width*0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(250, 185, 90, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Zmień pomieszczenie",
                  style: TextStyle(
                      fontSize: elementsOffset,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: elementsOffset,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: elementsOffset * 4,
                    width: rozmiar.width * 0.33,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 123, 107, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Anuluj",
                      style: TextStyle(
                          fontSize: elementsOffset,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: elementsOffset * 4,
                    width: rozmiar.width * 0.53,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Zatwierdź raport",
                      style: TextStyle(
                          fontSize: elementsOffset,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
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
