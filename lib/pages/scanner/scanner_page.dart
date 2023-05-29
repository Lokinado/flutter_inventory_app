import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:math';
import 'package:inventory_app/components/element_styling.dart';
import 'package:list_picker/list_picker.dart';
import 'package:inventory_app/pages/scanner/finish_report.dart';
import 'package:inventory_app/pages/scanner/change_place.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
      height: rozmiar.height * 0.295,
      width: rozmiar.width * 0.8,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: AspectRatio(
          aspectRatio: 1,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}

class CameraPagePrev extends StatefulWidget {
  const CameraPagePrev({
    Key? key,
    required this.budynek,
    required this.pietro,
    required this.pomieszczenie,
  }) : super(key: key);

  final int budynek;
  final int pietro;
  final int pomieszczenie;

  @override
  State<CameraPagePrev> createState() => _CameraPagePrevState();
}

class _CameraPagePrevState extends State<CameraPagePrev>
    with SingleTickerProviderStateMixin {
  late AnimationController localAnimationController;
  late TextEditingController _textEditingController;

  /// Zmienne przechowywujące informacje nt. przedmiotów do skanownaia
  List<List<dynamic>> krzesla = [];
  List<List<dynamic>> monitory = [];
  List<List<dynamic>> biurka = [];

  /// Zmienne do późńiejszego zainicjowania
  late int liczbaKrzesel;
  late int liczbaMonitorow;
  late int liczbaBiurek;

  late int budynek;
  late int pietro;
  late int pomieszczenie;

  var dummyVar = true;

  late String scannedValue;

  var refresh = false;
  var runMessage = false;

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
    if (dummyVar) {
      List<List<List<dynamic>>> zwrot = losuj();

      krzesla = zwrot[0];
      monitory = zwrot[1];
      biurka = zwrot[2];

      scannedValue = krzesla[1][1].toString();

      budynek = widget.budynek;
      pietro = widget.pietro;
      pomieszczenie = widget.pomieszczenie;

      dummyVar = false;
    }

    if (refresh){

      kom(context);

      refresh = false;
    }


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
              "${(i + 1).toString()}:  ${wybor[i][1].toString()}  ${wybor[i][2].toString()} ${wybor[i][3].toString()}");
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
/*
            TapBounceContainer(
              onTap: () {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message:
                    'There is some information. You need to do something with that',
                  ),
                );
              },
              child: buildButton(context, 'Show info'),
            ),
            const SizedBox(height: 24),


            TapBounceContainer(
              onTap: () {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: 'Persistent SnackBar',
                  ),
                  persistent: true,
                  onAnimationControllerInit: (controller) {
                    localAnimationController = controller;
                  },
                );
              },
              child: buildButton(context, 'Show persistent SnackBar'),
            ),
            const SizedBox(height: 24),
            TapBounceContainer(
              onTap: () => localAnimationController.reverse(),
              child: buildButton(context, 'Dismiss persistent SnackBar'),
            ),
            const SizedBox(height: 24),
            TapBounceContainer(
              onTap: () {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: 'Try to swipe me left',
                  ),
                  dismissType: DismissType.onSwipe,
                  dismissDirection: [DismissDirection.endToStart],
                );
              },
              child: buildButton(
                context,
                'Show swiped dismissible SnackBar',
              ),
            ),
*/
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
                  child: GestureDetector(
                    onTap: () async {
                      var wynik = await codeDialog();

                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      //color: Colors.red,
                      alignment: Alignment.center,
                      height: textHeighOffset * 1,
                      width: rozmiar.width * 0.7,
                      child: const Text(
                        "Dodaj kod ręcznie",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          //fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
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
                    if (scannedValue.isNotEmpty) {
                      var result = commentDialog("Przedmiot: $scannedValue");
                      if (result.toString().isNotEmpty) {
                        setState(() {
                          dodajKomentarz(
                              scannedValue, _textEditingController.text);
                        });
                      }
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
                        color: scannedValue.isNotEmpty
                            ? Colors.black
                            : Colors.black38,
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FinishReportPage()));
                  },
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
                          fontSize: elementsOffset * 1.1,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var wynik = await doZmianyPomieszczenia(context);
                    if (wynik != null) {
                      print("object");
                      setState(() {
                        if (!((budynek == wynik[0]) &&
                            (pietro == wynik[1]) &&
                            (pomieszczenie == wynik[2]))) {
                          budynek = wynik[0];
                          pietro = wynik[1];
                          pomieszczenie = wynik[2];
                          dummyVar = true;
                        }
                      });
                    }
                  },
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
                          fontSize: elementsOffset * 1.1,
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

  Container buildButton(BuildContext context, String text) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 6,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Future kom(context) async{
    showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message:
          'Something went wrong. Please check your credentials and try again',
        ), animationDuration: const Duration(seconds: 1)
    );
  }

  /// Początkowa inicjalizacja ekranu
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    //_controller = AnimationController(vsync: this);
  }

  /// Usuwanie stanu ekranu po wyjściu
  @override
  void dispose() {
    //_controller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  Future<bool> sprawdzenie(BuildContext sprawdzenie) async{
    return true;
  }

  /// Metoda tymczasowa - generowanie danych do testów
  List<List<List<dynamic>>> losuj() {
    biurka = [];
    monitory = [];
    krzesla = [];

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

    return [krzesla, monitory, biurka];
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

  Future komunikat(context,value, tekst) async{
    Future.delayed(const Duration(seconds: 2));
    if (value){
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message:
          tekst,
        ),
      );
    }
    else{
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          tekst,
        ),
      );
    }

  }

  /// Okienko do wyświetlania popupu do dodania komentarza
  Future commentDialog(naglowek) => showDialog(
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

  Future codeDialog() async{
    final result = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Wpisz kod ręcznie"),
      content: TextField(
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: const InputDecoration(hintText: "Wprowadź kod"),
        controller: _textEditingController,
      ),
      actions: [
        TextButton(
          child: const Text(
            "Anuluj",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            _textEditingController.text = "";
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            "Zatwierdź kod",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(_textEditingController.text);
          },
        ),
      ],
    ),
  );

    //await Future.delayed(Duration(seconds: 2));
    if (_textEditingController.text != "") {
      var czyWBazie = await szukajAzZnajdziesz(_textEditingController.text.toString());
      if (czyWBazie){
        showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
            message:
            'Dodano element do zeskanowanych przedmiotów',
        ), animationDuration: Duration(microseconds: 500));
      }
      else{
        showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message:
              'Elementu nie ma w bazie',
            ), animationDuration: Duration(microseconds: 500));
      }
    }

  }

  Future<bool> szukajAzZnajdziesz(wartosc) async{

    for (List<List<dynamic>> l in [krzesla, monitory, biurka]){
      for (int i = 0; i < l.length; i++){
        if (l[i][1] == wartosc){
          l[i][2] = true;
          return true;
        }
      }
    }
    return false;

  }

  Future<List<int>?> doZmianyPomieszczenia(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChangePlacePage(
            budynek: widget.budynek,
            pietro: widget.pietro,
            pomieszczenie: widget.pomieszczenie)));
    return result;
  }

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
