import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/pages/scanner/ready_report.dart';
import 'package:inventory_app/components/popups.dart';

class FinishReportPage extends StatefulWidget {
  const FinishReportPage({Key? key}) : super(key: key);

  @override
  State<FinishReportPage> createState() => _FinishReportPageState();
}

class _FinishReportPageState extends State<FinishReportPage> {
  /// Przechowuje rezultat wyskakujacych popupowych okienek
  late TextEditingController _textEditingController;

  /// Zdefiniowanie zmiennej do grubości tekstu definiowanana jako late, bo
  /// grubość tekstu ma zależeć od wysokości strony
  late TextStyle czanyGrubyTekst;

  /// Przy generowaniu raportu wstawiamy datę
  var dzisiaj = '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';

  var czyZainic = true; /// Zmienne odpowiedzialna za jednor. inicjalizację

  @override
  Widget build(BuildContext context) {
    /// Pobranie informacji nt. wymiarów okna
    final Size rozmiar = MediaQuery.of(context).size;

    // Przygotowanie zmiennenych pomodniczych do rozmiarowania elementów
    double textHeighOffset = rozmiar.height * 0.04;
    double elementsOffset = rozmiar.height * 0.023;

    /// Zmienne do zainicjalizowania przy uruchomieniu strony (tylko raz)
    if (czyZainic) {
      czanyGrubyTekst = TextStyle(
          fontSize: elementsOffset,
          color: Colors.black,
          fontWeight: FontWeight.w500);
      czyZainic = false;
    }

    return Scaffold(
      /// Nagłówek aplikacji
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: zielonySGGW,
        toolbarHeight: textHeighOffset * 3,
        centerTitle: true,
        title: const Text(
          "Podsumowanie",
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
          children: [
            /// Sekcja odpowiedzialna za wyświetlanie podlgądu skanowania
            Container(
              height: rozmiar.height * 0.6,
              width: rozmiar.width,
              alignment: Alignment.center,
              child: Container(
                height: rozmiar.height * 0.53,
                width: rozmiar.width * 0.9,
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Text("Tutaj będzie raport"),
              ),
            ),

            /// Guzik zmiany pomieszczenia
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop("zmienpomieszczenie");
              },
              child: Container(
                height: elementsOffset * 4,
                width: rozmiar.width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: zoltyPrzyciskStron,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Zmień pomieszczenie",
                  style: czanyGrubyTekst,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            /// Separotr horyzontalny między guzikami
            SizedBox(
              height: elementsOffset,
            ),

            /// Guziki na dole
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Guzik zakończenia skanowania
                GestureDetector(
                  onTap: () async {
                    var wynik = await confirmAction(
                        context,
                        "Ostrzeżenie",
                        "Czy chcesz porzucić tworzenie raportu?",
                        TextStyle(),
                        TextStyle(),
                        czerwonyTekst,
                        niebieskiTekst);
                    if (wynik) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop("reset");
                    }
                  },
                  child: Container(
                    height: elementsOffset * 4,
                    width: rozmiar.width * 0.33,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 0, 0, 0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Porzuć zmiany",
                      style: czanyGrubyTekst,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                /// Guzik zatwierdzenia raportu
                GestureDetector(
                  onTap: () async {
                    var wynik = await confirmActionRev(
                        context,
                        "Informacja",
                        "Zakończyć tworzenie raportu",
                        TextStyle(),
                        TextStyle(),
                        zielonyTekst,
                        czerwonyTekst);
                    if (wynik) {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReadyReportPage(
                              numerRaportu: 10,
                              data: dzisiaj)));
                    }
                  },
                  child: Container(
                    height: elementsOffset * 4,
                    width: rozmiar.width * 0.53,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(16, 142, 15, 1),
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
}
