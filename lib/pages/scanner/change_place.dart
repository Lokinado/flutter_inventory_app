import 'package:flutter/material.dart';
import 'dart:math';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:list_picker/list_picker.dart';

class ChangePlacePage extends StatefulWidget {
  const ChangePlacePage({Key? key}) : super(key: key);

  @override
  State<ChangePlacePage> createState() => _ChangePlacePageState();
}

class _ChangePlacePageState extends State<ChangePlacePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textEditingController;

  var budynek = 0;
  var pietro = 0;
  var pomieszczenie = 0;
  double numberBoxSize = 60;
  var rozpoczeteSkanowanie = false;



  separator(value) => SizedBox(
    height: value,
  );
  final controller = TextEditingController();

  List<String> listaBudynkow = [];
  List<List<String>> pietra = [];
  List<List<List<String>>> pomieszczenia = [];

  void inicjalizujPusteDane() {
    for (int i = 1; i <= 40; i++) {
      listaBudynkow.add(i.toString());
    }

    for (int i = 0; i < listaBudynkow.length; i++) {
      List<String> tmp = [];
      for (int j = 1; j <= 1 + Random().nextInt(2); j++) {
        tmp.add(j.toString());
      }
      pietra.add(tmp);
    }

    for (int i = 0; i < listaBudynkow.length; i++) {
      List<List<String>> bud = [];
      for (int j = 0; j < pietra[i].length + 1; j++) {
        List<String> piet = [];
        for (int p = 1; p <= 10 + Random().nextInt(50); p++) {
          piet.add(p.toString());
        }
        bud.add(piet);
      }
      pomieszczenia.add(bud);
    }
  }




  @override
  Widget build(BuildContext context) {

    // Pobranie informacji nt. wymiarów okna
    final Size rozmiar = MediaQuery.of(context).size;

    // Przygotowanie zmiennenych pomodniczych do rozmiarowania elementów
    double textHeighOffset = rozmiar.height * 0.04;
    double elementsOffset = rozmiar.height * 0.023;


    /// Zmienne które można zainicjalizować dopiero w konstruktorze
    var roundness = 20.0;
    double space = 20;
    inicjalizujPusteDane();
    var szerokoscPrzycisku = rozmiar.width - 120;


    return Scaffold(

      /// Nagłówek aplikacji
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Container(
        color: Colors.white,
        child: SizedBox(
          height: rozmiar.height,
          width: rozmiar.width,

          ///  Największe pudełko - tutaj jest cała zawartość równo ułożone
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// Wszystkie elementy są ułożone tutaj
              // po co Columna w Columne?
              // Jedna umieszcz an środku "pudełko" (column poniżej)
              // w którym sa już ręcznie rozmieszczonoe elementy
              // (przyciski i separatory z Column poniżej)
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,

                /// Budynek, piętro, pomieszczenie i przycisk
                children: [
                  /// Wybor budynku
                  // Dokładny opis komponentu w place_choose_button.dart
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: numberBoxSize,
                          height: numberBoxSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(roundness),
                              color: zielonySGGW),
                          child: Text(
                            // Podstawienie wybranego numeru jeśli > 0
                            "${budynek > 0 ? budynek : ""}",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                        // Pusty separator
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                        ),
                        SizedBox(
                          width: szerokoscPrzycisku,
                          height: 60.0,
                          child: ElevatedButton(
                            style: leftTextActive,
                            onPressed: () async {
                              String? wyborBudynku = await showPickerDialog(
                                context: context,
                                label: "Budynek",
                                items: listaBudynkow,
                              );
                              if (wyborBudynku != null) {
                                var value = int.parse(wyborBudynku);
                                setState(() {
                                  if (budynek != value) {
                                    budynek = value;
                                    pietro = 0;
                                    pomieszczenie = 0;
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Budynek",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Separator
                  separator(space),

                  /// Wybor pietra
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: numberBoxSize,
                          height: numberBoxSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(roundness),
                              color:
                              budynek != 0 ? zielonySGGW : zielonySlabaSGGW),
                          child: Text(
                            "${pietro > 0 ? pietro : ""}",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                        ),
                        SizedBox(
                          width: szerokoscPrzycisku,
                          height: 60.0,
                          child: ElevatedButton(
                            style:
                            budynek != 0 ? leftTextActive : leftTextNotActive,
                            onPressed: () async {
                              if (budynek != 0){
                                String? wyborPietra = await showPickerDialog(
                                  context: context,
                                  label: "",
                                  items: pietra[budynek],
                                );
                                if (wyborPietra != null) {
                                  var value = int.parse(wyborPietra);
                                  setState(() {
                                    if (pietro != value) {
                                      pietro = value;
                                      pomieszczenie = 0;
                                    }
                                  });
                                }
                              }
                            },
                            child: const Text(
                              "Piętro",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Separator
                  separator(space),

                  /// Wybor pomieszczenia
                  Container(
                    margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: numberBoxSize,
                          height: numberBoxSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(roundness),
                              color:
                              pietro != 0 ? zielonySGGW : zielonySlabaSGGW),
                          child: Text(
                            "${pomieszczenie > 0 ? pomieszczenie : ""}",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(space, 0, 0, 0),
                        ),
                        SizedBox(
                          width: szerokoscPrzycisku,
                          height: 60.0,
                          child: ElevatedButton(
                            style: pietro != 0 && budynek != 0
                                ? leftTextActive
                                : leftTextNotActive,
                            onPressed: () async {
                              if (pietro != 0){
                                String? wyborPomieszczenia = await showPickerDialog(
                                  context: context,
                                  label: "Budynek",
                                  items: pomieszczenia[budynek][pietro],
                                );
                                if (wyborPomieszczenia != null) {
                                  setState(() {
                                    pomieszczenie = int.parse(wyborPomieszczenia);
                                  });
                                }
                              }
                            },
                            child: const Text(
                              "Pomieszczenie",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Separator
                  separator(4 * space),



                ],
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
                            fontSize: elementsOffset * 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (pomieszczenie > 0){
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      height: elementsOffset * 4,
                      width: rozmiar.width * 0.53,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pomieszczenie > 0 ? Colors.green : Colors.green.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Zmiana",
                        style: TextStyle(
                            fontSize: elementsOffset * 1.2,
                            color: pomieszczenie > 0 ? Colors.black : Colors.black.withOpacity(0.4),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
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
