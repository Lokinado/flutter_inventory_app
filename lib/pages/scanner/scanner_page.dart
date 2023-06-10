// Elementy systemowe
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:list_picker/list_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:scan/scan.dart';

// Linki do innych plików projekcie
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/pages/scanner/finish_report.dart';
import 'package:inventory_app/pages/scanner/change_place.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:inventory_app/database/report_generator.dart';

class DemoCamPage extends StatefulWidget {
  const DemoCamPage({
    Key? key,
    required this.budynek,
    required this.pietro,
    required this.pomieszczenie,
  }) : super(key: key);

  final String budynek;
  final String pietro;
  final String pomieszczenie;

  @override
  State<DemoCamPage> createState() => _DemoCamPageState();
}

class _DemoCamPageState extends State<DemoCamPage> {
  //
  // Przypisanie i inicjalizacja zmiennych
  //

  /// Zmienna która odpowiada za odświerzenie zmiennych po pojawieniu się popupu
  var inicjalizujDane = true;

  /// Utworzeni / pobranie danych do / z bazy
  var odswierzRozmiar = true;

  /// Pobranie wszystkich przedmiotów do skanowania, podzielnoych na kategorie
  Map<String, Map<String, String>> przedmiotyWgTypu = {};

  Map<String, Map<String, String>> zeskanowanePrzedmioty = {};

  // Zmienne przechowywujące informacje nt. przedmiotów do skanownaia

  /// Lista krzeseł w sali w raz z informacjami
  late List<List<dynamic>> krzesla = [];

  /// Lista monitorow w sali w raz z informacjami
  late List<List<dynamic>> monitory = [];

  /// Lista biurek w sali w raz z informacjami
  late List<List<dynamic>> biurka = [];

  // Przy wyświetlaniu okienek potrzebna jest lista tekstowa więc dla każdego
  // zbioru eementów tworzę taką listę
  /*
  *
  /// Dynamicznie utworznona lista krzesel
  late List<String> krzeslaIdentyfikatory = [];

  /// Dynamicznie utworznona lista monitorów
  late List<String> monitoryIdentyfikatory = [];

  /// Dynamicznie utworznona lista biurek
  late List<String> biurkaIdentyfikatory = [];
  * */

  Map<String, List<String>> listaListElem = {};

  /// Przechowuje rezultat wyskakujacych popupowych okienek
  late TextEditingController _textEditingController;

  /// Kontroluje działanie kamery
  ScanController cameraController = ScanController();

  Map<String, int> zeskanowaneLiczba = {};

  // TE ZMIENNE MUSZĄ BYĆ, BO TYCH PRZEKAZYWNAYCH PRZY WYWOŁANIU STRONY
  // NIE DA SIĘ MODYFIKOWAĆ, WIĘC TRZEBA MIEĆ ODDZIELNY ZESTAW
  // do tych przekazywanch w parametrach dostajemy się poprzez 'widget. ...'

  /// Wybrany przez użytkownika budynek
  late String budynek;

  /// Wybrane przez użytkownika pietro
  late String pietro;

  /// Wybrane przez użytkownika pomieszczenie
  late String pomieszczenie;

  /// Zeskanowan wartość
  String scannedValue = "";

  /// Grubość offsetu na jakiś element - stylistyczna zmienna pomocnicza
  late double textHeighOffset;

  /// Grubość offsetu na jakiś element - stylistyczna zmienna pomocnicza
  late double elementsOffset;

  late Size rozmiar;

  late Report nowyRaport;

  //
  // Najważniejszy element budujący wszystko w tym pliku
  //

  @override
  Widget build(BuildContext context) {
    /// Pobranie informacji nt. wymiarów okna
    if (odswierzRozmiar) {
      rozmiar = MediaQuery.of(context).size;

      // Przygotowanie zmiennenych pomodniczych do rozmiarowania elementów
      textHeighOffset = rozmiar.height * 0.04;
      elementsOffset = rozmiar.height * 0.023;
      cameraController.pause();
      cameraController.resume();
    }

    /// Inicjalizacja zmienneych i dynamiczne zmiany ich wartości
    /// -> przechowują informacje nt. stanu skonowania elementów
    if (inicjalizujDane) {
      budynek = widget.budynek;
      pietro = widget.pietro;
      pomieszczenie = widget.pomieszczenie;

      pobierz(budynek, pietro, pomieszczenie);
      utworzRaport(budynek, pietro, pomieszczenie);

      for (var k in przedmiotyWgTypu.keys){
        listaListElem[k] = przedmiotyWgTypu[k]!.values.toList();
        zeskanowaneLiczba[k] = 0;
      }

      //przygotujZeskanowane();
      inicjalizujDane = false;
    }

    /// Odświeżenie elementów dynamicznych, jako komentarze, czy liczniki
    /// zeskanownaych elementów
    odswierzZeskanowane();

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
        body: Column(
          children: [
            /// Separator oddzielający szare pole z kamerą od nagłówka
            SizedBox(
              height: elementsOffset,
            ),

            listaElem(),

            /// Separator oddzielający przyciski dolne
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
                  child: GestureDetector(
                    onTap: () async {
                      await inputCodeManually();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
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
                camera(),
              ],
            ),

            /// Separator oddzielające pole z kamerą od zeskanowanej wartości
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
                  onTap: () async {
                    if (scannedValue.isNotEmpty) {
                      await commentDialog("Przedmiot: $scannedValue");
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

            /// Separator oddzielający zeskanowany kod od podsumowania
            SizedBox(
              height: elementsOffset * 1.5,
            ),

            /// Przyciski dolne na stronie
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Przycisk zakończenia raportu
                GestureDetector(
                  onTap: () async {
                    var wynik = await doZakonczeniaRaportu(context);
                    if (wynik == "zmienpomieszczenie") {
                      var wynik = await doZmianyPomieszczenia(context);
                      if (wynik != null) {
                        setState(() {
                          if (!((budynek == wynik[0]) &&
                              (pietro == wynik[1]) &&
                              (pomieszczenie == wynik[2]))) {
                            budynek = wynik[0];
                            pietro = wynik[1];
                            pomieszczenie = wynik[2];

                            inicjalizujDane = true;
                          }
                        });
                      }
                    }
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

                /// Przycisk zmiany pomieszczenia
                GestureDetector(
                  onTap: () async {
                    var wynik = await doZmianyPomieszczenia(context);
                    if (wynik != null) {
                      setState(() {
                        if (!((budynek == wynik[0]) &&
                            (pietro == wynik[1]) &&
                            (pomieszczenie == wynik[2]))) {
                          budynek = wynik[0].toString();
                          pietro = wynik[1].toString();
                          pomieszczenie = wynik[2].toString();
                          inicjalizujDane = true;
                        }
                      });
                      await pobierz(budynek, pietro, pomieszczenie);
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
        ));
  }

  //
  //  Funkcje używane w tym pliku
  //



  /// Widget wyświetlający działąjący skanner
  Widget camera() => Container(
        height: rozmiar.height * 0.3 - 6,
        width: rozmiar.width * 0.8,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: ScanView(
            controller: cameraController,
            scanAreaScale: .8,
            scanLineColor: Colors.green.shade400,
            onCapture: (data) async {
              setState(() {
                scannedValue = data;
              });
              // Kod wstrzymujcy dziaanie kamery
              cameraController.pause();

              // ... sprawdź czy element jest w bazie i ...
              var czyWBazie =
                  await szukajAzZnajdziesz(_textEditingController.text);

              // ... w zależności od odopowiedzi odznacz i pokaż odpowiedni komunikat
              if (czyWBazie) {
                showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message: 'Dodano element do zeskanowanych przedmiotów',
                    ),
                    animationDuration: const Duration(microseconds: 500));
              } else {
                showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: 'Elementu nie ma w bazie',
                    ),
                    animationDuration: const Duration(microseconds: 500));
              }
              await Future.delayed(const Duration(seconds: 1));
              cameraController.resume();
            },
          ),
        ),
      );

  /// Widget generujący dynamicznie listę elementów do wyswietlenia
  Widget listaElem() {
    return SizedBox(
      width: rozmiar.width * 0.87,
      height: rozmiar.height * 0.2,
      child: ListView(
        children: przedmiotyWgTypu.keys.map((item) {
          return Container(
            height: 2.5 * elementsOffset,
            margin: EdgeInsets.only(bottom: elementsOffset*0.2),
            child: ElevatedButton(
              onPressed: () async {
                nestedComentDialog(listaListElem[item], item);
              },
              style: zeskanowaneLiczba[item] == przedmiotyWgTypu[item]!.length
                  ? spacedGreenButtonActive
                  : spacedGreenButtonNActive,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item,
                    style: TextStyle(
                        fontSize: elementsOffset,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${zeskanowaneLiczba[item]}/${listaListElem[item]}",
                    style: TextStyle(
                        fontSize: elementsOffset,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Początkowa inicjalizacja ekranu
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  /// Usuwanie stanu ekranu po wyjściu
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  /// Po zeksnaowaniu należy odświerżyć wyświetlane dane w popupach, między
  /// innymi komentarze, i zeskanowane przedmoty
  Future odswierzZeskanowane() async {

  }

  Future pobierz(b, pi, po) async {
    przedmiotyWgTypu = await przedmiotyWKategoriach(b, pi, po);
  }

  Future utworzRaport(b, pi, po) async {
    nowyRaport = Report();
    await nowyRaport.nowePomieszczenie(b, pi, po);
  }

  /*/// Początkowe wpisanie danych - działa prawie tak jak 'odswierzZeksnowane'
  /// ale inicjalizuje dane, a nie je nadpisuje
  void przygotujZeskanowane() {
    liczbaKrzesel = liczGotowe(krzesla);
    liczbaMonitorow = liczGotowe(monitory);
    liczbaBiurek = liczGotowe(biurka);

    for (int lista = 0; lista < 3; lista++) {
      List<List<dynamic>> wybor = [krzesla, monitory, biurka][lista];
      List<String> identyfikatory = [
        krzeslaIdentyfikatory,
        monitoryIdentyfikatory,
        biurkaIdentyfikatory
      ][lista];
      for (int i = 0; i < wybor.length; i++) {
        identyfikatory.add(
            "${(i + 1).toString()}:  ${wybor[i][1].toString()}  ${wybor[i][2].toString()} ${wybor[i][3].toString()}");
      }
    }
  }*/

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
  Future commentDialog(naglowek) async {
    odswierzRozmiar = false;
    cameraController.pause();

    /// Kod wstrzymujcy dziaanie kamery
    final wynik = await showDialog(
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
      ),
    );

    await dodajKomentarz(scannedValue, wynik);

    /// dodaj komentarz do przedmiotu
    _textEditingController.text = "";

    /// zresetuj wpisaną wartość
    odswierzRozmiar = true;
    cameraController.resume();
  }

  Future nestedComentDialog(lista, naglowek) async {
    odswierzRozmiar = false;

    /// Kod wstrzymujcy dziaanie kamery
    cameraController.pause();

    while (true) {
      final wynik = await showPickerDialog(
        context: context,
        label: naglowek,
        items: listaListElem[lista]!,
      );

      if (wynik == null) {
        /// zresetuj wpisaną wartość
        odswierzRozmiar = true;
        cameraController.resume();

        /// dodaj komentarz do przedmiotu
        _textEditingController.text = "";

        /// zresetuj wpisaną wartość
        odswierzRozmiar = true;
        cameraController.resume();
        return;
      } else {
        wynik.split(": ")[1];
        final kom = await commentDialog("Przedmiot: $wynik");
        print(kom);
        await Future.delayed(Duration(seconds: 1));
        await dodajKomentarz(wynik, kom);
        await odswierzZeskanowane();
      }
    }
  }

  /// Popup do wpisania kodu ręcznie przy próbie skanowania
  Future inputCodeManually() async {
    odswierzRozmiar = false;
    cameraController.pause();

    /// Kod wstrzymujcy dziaanie kamery /// Kod wstrzymuj
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Wpisz kod ręcznie"),
        content: TextField(
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

    /// O ile wpisano jakiś kod to:
    if (_textEditingController.text != "") {
      /// ... sprawdź czy element jest w bazie i ...
      var czyWBazie =
          await szukajAzZnajdziesz(_textEditingController.text.toString());

      /// ... w zależności od odopowiedzi odznacz i pokaż odpowiedni komunikat
      if (czyWBazie) {
        showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: 'Dodano element do zeskanowanych przedmiotów',
            ),
            animationDuration: const Duration(microseconds: 500));
      } else {
        showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message: 'Elementu nie ma w bazie',
            ),
            animationDuration: const Duration(microseconds: 500));
      }

      /// A na koniec zresetuj zmmienną do przechwytywania teksut
      /// (bez tego po ponownym otwarciu popupu mamy wpisany poprzedni kod)
      _textEditingController.text = "";
      cameraController.resume();
    }
    odswierzRozmiar = true;
    cameraController.resume();
  }

  /// Rekurancyjne przeszukanie danych w celu odnalezienia i odznaczenia kodu
  Future<bool> szukajAzZnajdziesz(wartosc) async {
    for (var kategoria in przedmiotyWgTypu.keys) {
      for (var barcode in przedmiotyWgTypu[kategoria]!.keys) {}
    }

    for (List<List<dynamic>> l in [krzesla, monitory, biurka]) {
      for (int i = 0; i < l.length; i++) {
        if (l[i][1] == wartosc) {
          l[i][2] = true;
          return true;
        }
      }
    }
    return false;
  }

  /// Metoda która rekurencyjnie przeszukuje dane, i dla odpowiedniego elementu
  /// dodaje do niego przekazany komentarz
  /// zwraca true / false, w zależności od tego czy element jest w tym pomiedzczeniu
  Future<bool> dodajKomentarz(barcode, komentarz) async {
    for (List<List<dynamic>> l in [krzesla, monitory, biurka]) {
      for (int i = 0; i < l.length; i++) {
        if (l[i][1] == barcode) {
          l[i][3] = komentarz;
          return true;
        }
      }
    }
    return false;
  }

  /// Wywołanie asynchroniczne przechodzące do zakończenia raportu
  /// i ewentualnie zwracające informację o tym czy należy przejść do strony
  /// zmiany pomieszczenia
  Future<String> doZakonczeniaRaportu(BuildContext context) async {
    cameraController.pause();
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FinishReportPage(
              raport: nowyRaport,
            )));
    if (result == null) {
      cameraController.resume();
    } else {
      dispose();
    }
    return result;
  }

  /// Wywołanie asynchroniczne przechodząde to zmiany pomieszczenia
  /// i zwrtacające informacje listę oznaczajacaą pomieszczenia, lub null
  /// jeśli operacja została anulowana
  Future<List<String>> doZmianyPomieszczenia(BuildContext context) async {
    cameraController.pause();
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChangePlacePage(
              budynek: budynek,
              pietro: pietro,
              pomieszczenie: pomieszczenie,
            )));
    cameraController.resume();
    return result;
  }
}
