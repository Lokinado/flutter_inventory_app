import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:math';
import 'package:inventory_app/components/element_styling.dart';
import 'package:list_picker/list_picker.dart';

double cameraHeight = 300;
double cameraWidth = 380;



late List<CameraDescription> _cameras;

void cameraCheck() async {
  _cameras = await availableCameras();
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraPage> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    cameraCheck();
    controller = CameraController(
      _cameras[0],
      ResolutionPreset.low,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery.of(context).size;

    return SizedBox(
      height: rozmiar.height * 0.28,
      width: rozmiar.width * 0.8,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: AspectRatio(
          aspectRatio: 0.1,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}

class CameraPagePrev extends StatefulWidget {
  const CameraPagePrev({Key? key}) : super(key: key);

  @override
  State<CameraPagePrev> createState() => _CameraPagePrevState();
}





class _CameraPagePrevState extends State<CameraPagePrev>
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

    /// Inicjalizacja zmienneych i dynamiczne zmiany ich wartości
    /// -> przechowują informacje nt. stanu skonowania elementów
    liczbaBiurek = liczGotowe(biurka);
    liczbaMonitorow = liczGotowe(monitory);
    liczbaKrzesel = liczGotowe(krzesla);

    // Przechowuje informacje o ostatnim zeskanowanym elemencie
    var scannedValue = krzesla[1][1].toString();


    /// Pola przechoujące pozostałe do zeskanowania elementy
    /// W chewili obecnej ma to na celu pokazanie że dynamicznie da się
    /// modyfikowąc liczbę elementów wyświetlanych na popupowych listatach
    /// do zmienienia później
    List<String> krzeslaIdentyfikatory = [];
    List<String> monitoryIdentyfikatory = [];
    List<String> biurkaIdentyfikatory = [];

    for (int lista = 0; lista < 3; lista++) {
      List<List<dynamic>> wybor = [krzesla, monitory, biurka][lista];
      List<String> identyfikatory = [
        krzeslaIdentyfikatory,
        monitoryIdentyfikatory,
        biurkaIdentyfikatory
      ][lista];
      for (int i = 0; i < wybor.length; i++) {
        if (!wybor[i][2]) {
          identyfikatory.add(
              "${(i + 1).toString()} : ${wybor[i][1].toString()}  ${wybor[i][2].toString()} | ${wybor[i][3].toString()}");
        }
      }
    }

    return Scaffold(

      /// Nagłówek aplikacji
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        toolbarHeight: textHeighOffset * 3,
        centerTitle: true,
        title: const Text(
          "Skanowanie",
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
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            /// Separator
            SizedBox(
              height: elementsOffset,
            ),

            /// Kamera razem z polem komentarz
            Stack(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: rozmiar.height * 0.3 + textHeighOffset,
                  width: rozmiar.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(190, 186, 185, 1),
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: textHeighOffset,
                    child: Text("Kliknij, by wpisać kod ręcznie",
                        style: TextStyle(fontSize: elementsOffset * 0.9)),
                  ),
                ),
                //const CameraPage(),
              ],
            ),

            /// Separator
            SizedBox(
              height: elementsOffset * 1.5,
            ),

            /// Podgląd ostatniego kodu + komentarz
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: elementsOffset * 3,
                  width: rozmiar.width * 0.5,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(88, 178, 122, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Container(
                    width: rozmiar.width * 0.5,
                    alignment: Alignment.center,
                    child: Text(scannedValue,
                        style: TextStyle(
                            fontSize: elementsOffset * 1.2,
                            color: Colors.white)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var result = openDialog("Przedmiot: $scannedValue");
                    if (result.toString().isNotEmpty) {
                      setState(() {
                        dodajKomentarz(
                            scannedValue, _textEditingController.text);
                      });
                    }
                  },
                  child: Container(
                    width: rozmiar.width * 0.3,
                    height: elementsOffset * 3,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Text(
                      "Dodaj komentarz",
                      style: TextStyle(
                        fontSize: elementsOffset * 0.9,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

            /// Separatro
            SizedBox(
              height: elementsOffset * 1.5,
            ),

            /// Wyświetlanie zeskanowanych przedmiotów
            Column(
              children: [
                SizedBox(
                  width: rozmiar.width * 0.8,
                  height: 2.5 * elementsOffset,
                  child: ElevatedButton(
                    style: liczbaKrzesel == krzesla.length
                        ? spacedGreenButtonActive
                        : spacedGreenButtonNActive,
                    onPressed: () async {
                      String? wybraneKrzeslo = await showPickerDialog(
                        context: context,
                        label: "krzesło",
                        items: krzeslaIdentyfikatory,
                      );
                      if (wybraneKrzeslo != null) {
                        setState(() {
                          krzesla[int.parse(wybraneKrzeslo.split(":")[0]) - 1]
                              [2] = true;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: elementsOffset * 0.2,
                          right: elementsOffset * 0.2),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Krzesło",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "$liczbaKrzesel/${krzesla.length}",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: rozmiar.width * 0.8,
                  height: 2.5 * elementsOffset,
                  child: ElevatedButton(
                    style: liczbaMonitorow == monitory.length
                        ? spacedGreenButtonActive
                        : spacedGreenButtonNActive,
                    onPressed: () async {
                      String? wybranyMonitor = await showPickerDialog(
                        context: context,
                        label: "monitor",
                        items: monitoryIdentyfikatory,
                      );
                      if (wybranyMonitor != null) {
                        setState(() {
                          monitory[int.parse(wybranyMonitor.split(":")[0]) - 1]
                              [2] = true;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: elementsOffset * 0.2,
                          right: elementsOffset * 0.2),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Monitory",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "$liczbaMonitorow/${monitory.length}",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: rozmiar.width * 0.8,
                  height: 2.5 * elementsOffset,
                  child: ElevatedButton(
                    style: liczbaBiurek == biurka.length
                        ? spacedGreenButtonActive
                        : spacedGreenButtonNActive,
                    onPressed: () async {
                      String? wybraneBiurko = await showPickerDialog(
                        context: context,
                        label: "biurko",
                        items: biurkaIdentyfikatory,
                      );
                      if (wybraneBiurko != null) {
                        setState(() {
                          biurka[int.parse(wybraneBiurko.split(":")[0]) - 1]
                              [2] = true;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: elementsOffset * 0.2,
                          right: elementsOffset * 0.2),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Biurko",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "$liczbaBiurek/${biurka.length}",
                            style: TextStyle(
                                fontSize: elementsOffset,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// Separator
            SizedBox(
              height: elementsOffset * 1.5,
            ),

            /// Przyciski dolne na stronie
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: elementsOffset * 4,
                    width: rozmiar.width * 0.33,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 123, 107, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Zakończ raport",
                      style: TextStyle(
                          fontSize: elementsOffset * 1.2,
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
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(250, 185, 90, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Zmień pomieszczenie",
                      style: TextStyle(
                          fontSize: elementsOffset * 1.2,
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

  /// Zliczanie gotowych elementów na liście dynamicznej
  /// do użycia by pokazać ile już zeskanowano elementów
  int liczGotowe(List<List<dynamic>> lista) {
    int licznik = 0;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i][2]) {
        licznik++;
      }
    }
    return licznik;
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

  /// Metoda nadpisująca listy danych o wpisany komentarz
  /// znajduje do kórego elementu wpisano komentarz
  /// i temu elementowi go przypisuje (bez wzgl. na listę)
  void dodajKomentarz(element, komentarz) {
    for (List<List<dynamic>> l in [monitory, krzesla, biurka]) {
      for (List<dynamic> ld in l) {
        if (ld[1].toString() == element) {
          ld[3] = komentarz;
          return;
        }
      }
    }
  }
}
