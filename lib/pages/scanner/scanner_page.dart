// Elementy systemowe
import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:list_picker/list_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart'; // komunikaty
import 'package:top_snackbar_flutter/top_snack_bar.dart'; // nagłowek
import 'package:scan/scan.dart'; // skaner

// Linki do innych plików projekcie
import 'package:inventory_app/components/element_styling.dart'; // kolory
import 'package:inventory_app/pages/scanner/finish_report.dart'; // strona zakończ
import 'package:inventory_app/pages/scanner/change_place.dart'; // strona zmień
import 'package:inventory_app/database/place_to_list.dart'; // pobieranie danych
import 'package:inventory_app/database/report_generator.dart'; // obsł. raportu

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

  /// Zmienna która ogranicza wykonanie części instrukcji tylko przy pierwszej
  /// inicjalizacji naszego elementu
  var inicjalizujRaz = true;

  /// Zmienna która odpowiada za odświerzenie zmiennych po pojawieniu się popupu
  var inicjalizujDane = true;

  /// Utworzeni / pobranie danych do / z bazy
  var odswierzRozmiar = true;

  /// Pobranie wszystkich przedmiotów do skanowania, podzielnoych na kategorie
  Map<String, Map<String, String>> przedmiotyWgTypu = {};

  /// Tablica przechowywująca zeskanowane przedmioty w danej sesji
  Map<String, Map<String, String>> zeskanowanePrzedmioty = {};

  // Zmienne przechowywujące informacje nt. przedmiotów do skanownaia

  /// Lista przechowująca listy kodów kategorii do wyświetlania w dymkach
  Map<String, List<String>> listaListElem = {};

  /// Przechowuje rezultat wyskakujacych popupowych okienek
  late TextEditingController _textEditingController;

  /// Kontroluje działanie kamery
  ScanController cameraController = ScanController();

  /// Zmienna przechowywujaca info ile kodów już zeskanowano
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

  /// Zmienna przechowyująca rozmiary wyświetlanego okna
  late Size rozmiar;

  /// Zmienna przechowyująca nowy raport
  late Report nowyRaport;

  //
  // Najważniejszy element budujący wszystko w tym pliku
  //

  @override
  Widget build(BuildContext context) {
    //cameraController.pause();
    //cameraController.resume();

    if (inicjalizujRaz) {
      nowyRaport = Report();
      budynek = widget.budynek;
      pietro = widget.pietro;
      pomieszczenie = widget.pomieszczenie;
      inicjalizujRaz = false;
    }

    //cameraController.pause();
    //cameraController.resume();

    if (inicjalizujRaz){
      budynek = widget.budynek;
      pietro = widget.pietro;
      pomieszczenie = widget.pomieszczenie;
      inicjalizujRaz = false;
    }

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
      pobierzPrzedmioty(budynek, pietro, pomieszczenie);

      inicjalizujDane = false;
    }
    /// Odświeżenie elementów dynamicznych, jako komentarze, czy liczniki
    /// zeskanownaych elementów
    odswierzZeskanowane();
  print("tu lista $przedmiotyWgTypu");
    return Scaffold(

        // Nagłówek aplikacji
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: zielonySGGW,
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

        // Zawartość ciała
        body: Column(
          children: [
            // Separator oddzielający szare pole z kamerą od nagłówka
            SizedBox(
              height: elementsOffset,
            ),

            // Dynamicznie wygeneorana lista przycisków do skanowania kateroii
            listaElem(),

            // Separator oddzielający przyciski dolne
            SizedBox(
              height: elementsOffset,
            ),

            // Kamera razem z polem komentarz
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

            // Separator oddzielające pole z kamerą od zeskanowanej wartości
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

            // Przyciski dolne na stronie
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Przycisk zakończenia raportu
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
                          }
                        });
                        await pobierzPrzedmioty(budynek, pietro, pomieszczenie);
                      }
                    }
                  },
                  child: Container(
                    height: elementsOffset * 4,
                    width: rozmiar.width * 0.33,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: lososiowyCzerwony,
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

                // Przycisk zmiany pomieszczenia
                GestureDetector(
                  onTap: () async {
                    await doZmianyPomieszczenia(context);
                  },
                  child: Container(
                    height: elementsOffset * 4,
                    width: rozmiar.width * 0.53,
                    alignment: Alignment.center,
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
  Widget camera() => SizedBox(
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
                  await checkItemsInRoom(_textEditingController.text);

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
            margin: EdgeInsets.only(bottom: elementsOffset * 0.2),
            child: ElevatedButton(
              onPressed: () async {
                if (przedmiotyWgTypu[item]!.keys.length > 0 || zeskanowanePrzedmioty[item]!.keys.length > 0)
                  {
                    while (true) {
                      String? wynik = await showPickerDialog(
                        context: context,
                        label: item,
                        items: zeskanowanePrzedmioty[item]!
                            .keys
                            .map((elem) => zeskanowanePrzedmioty[item]![elem] != ""
                            ? "$elem : ${zeskanowanePrzedmioty[item]![elem]}"
                            : elem)
                            .toList()
                            .map((item) => item.toString())
                            .toList(),
                      );
                      if (wynik == null) {
                        break;
                      } else {
                        var kom = await commentDialog("$item: $wynik");
                        await dodajKomentarz(wynik, kom);
                      }
                    }
                  }
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
                    "${zeskanowaneLiczba[item]}/${listaListElem[item]!.length}",
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
    for (var k in zeskanowanePrzedmioty.keys) {
      zeskanowaneLiczba[k] = zeskanowanePrzedmioty[k]!.length;
    }
  }

  /// Funkcja zaciągająca dane z naszej bazy wiedząc jakie pomieszczenie chcemy
  /// zeskanować
  Future pobierzPrzedmioty(b, pi, po) async {
    print("I AM DOWNLOADING");
    przedmiotyWgTypu = await przedmiotyWKategoriach(b, pi, po);

    await nowyRaport.nowePomieszczenie(b, pi, po);
    print("KURWA CHUJ DUPA");
    print(nowyRaport.doZeskanowania.keys.length);

    for (var k in przedmiotyWgTypu.keys) {
      listaListElem[k] = await przedmiotyWgTypu[k]!.values.toList();
      zeskanowaneLiczba[k] = 0;
      zeskanowanePrzedmioty[k] = {};
    }
    setState(() {
      przedmiotyWgTypu = przedmiotyWgTypu;
    });
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

  /// Okiednko które umożliwia wprowadzenie komentarza do konkretnego elementu
  /// w naszej bazie wg. kategorii
  Future nestedComentDialog(lista, naglowek) async {
    odswierzRozmiar = false;

    /// Kod wstrzymujcy dziaanie kamery
    cameraController.pause();

    while (true) {
      final wynik = await showPickerDialog(
        context: context,
        label: naglowek,
        items: listaListElem[lista]!
            .map((item) => zeskanowanePrzedmioty[lista]![item] != ""
                ? "$item : ${zeskanowanePrzedmioty[lista]![item]}"
                : "$item")
            .toList()
            .map((item) => item.toString())
            .toList(),
      );

      print(
        listaListElem[lista]!
            .map((item) => zeskanowanePrzedmioty[lista]![item] != ""
                ? "$item : ${zeskanowanePrzedmioty[lista]![item]}"
                : "$item")
            .toList()
            .map((item) => item.toString())
            .toList(),
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
        await dodajKomentarz(wynik, kom);
        await odswierzZeskanowane();
        setState(() {
          zeskanowanePrzedmioty = zeskanowanePrzedmioty;
        });
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

    setState(() {
      scannedValue = _textEditingController.text;
    });

    /// O ile wpisano jakiś kod to:
    if (_textEditingController.text != "") {
      /// ... sprawdź czy element jest w bazie i ...
      var czyWBazie = await checkItemsInRoom(_textEditingController.text);

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
  /// wśród elementów w naszym pomieszczeniu
  Future<bool> checkItemsInRoom(barcode) async {
    for (var kategoria in przedmiotyWgTypu.keys) {
      for (var elem in przedmiotyWgTypu[kategoria]!.keys) {
        if (elem == barcode) {
          zeskanowanePrzedmioty[kategoria]![barcode] = "";
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
    for (var kategoria in przedmiotyWgTypu.keys) {
      for (var elem in przedmiotyWgTypu[kategoria]!.keys) {
        if (elem == barcode) {
          zeskanowanePrzedmioty[kategoria]![barcode] = komentarz;
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
    await nowyRaport.wpiszNoweZmiany(
        budynek, pietro, pomieszczenie, zeskanowanePrzedmioty);
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FinishReportPage(
              raport: nowyRaport,
            )));
    if (result == null) {
      cameraController.resume();
    }
    return result;
  }

  /// Wywołanie asynchroniczne przechodząde to zmiany pomieszczenia
  /// i zwrtacające informacje listę oznaczajacaą pomieszczenia, lub null
  /// jeśli operacja została anulowana
  Future doZmianyPomieszczenia(BuildContext context) async {
    cameraController.pause();
    final wynik = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChangePlacePage(
              budynek: budynek,
              pietro: pietro,
              pomieszczenie: pomieszczenie,
            )));
    if (wynik != null) {
      await nowyRaport.wpiszNoweZmiany(
          budynek, pietro, pomieszczenie, zeskanowanePrzedmioty);
      setState(() {
        if (!((budynek == wynik[0]) &&
            (pietro == wynik[1]) &&
            (pomieszczenie == wynik[2]))) {
          budynek = wynik[0];
          pietro = wynik[1];
          pomieszczenie = wynik[2];
        }
      });
      setState(() {
        scannedValue = "";
      });
      //może by się przydało jakieś raport clear?
      await nowyRaport.nowePomieszczenie(budynek, pietro, pomieszczenie);
      await pobierzPrzedmioty(budynek, pietro, pomieszczenie);
      await odswierzZeskanowane();
    }
    cameraController.resume();
  }
}
