import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/pages/scanner/ready_report.dart';
import 'package:inventory_app/components/popups.dart';
import 'package:inventory_app/database/report_generator.dart';
import 'package:inventory_app/database/report_to_db.dart';
import 'package:inventory_app/database/place_to_list.dart';

class FinishReportPage extends StatefulWidget {
  FinishReportPage({Key? key, required this.raport}) : super(key: key);

  Report raport;

  @override
  State<FinishReportPage> createState() => _FinishReportPageState();
}

class _FinishReportPageState extends State<FinishReportPage> {
  bool isLoading = true;
  /// Przechowuje rezultat wyskakujacych popupowych okienek
  late TextEditingController _textEditingController;

  /// Zdefiniowanie zmiennej do grubości tekstu definiowanana jako late, bo
  /// grubość tekstu ma zależeć od wysokości strony
  late TextStyle czanyGrubyTekst;

  /// Przy generowaniu raportu wstawiamy datę
  var dzisiaj =
      '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';

  var czyZainic = true;

  /// Zmienne odpowiedzialna za jednor. inicjalizację

  Widget GenerateSummary(Report raport, Size rozmiar, String Buildings,
      String Floor, String Room) {
    if (raport.doZeskanowania.isEmpty) return SizedBox.shrink();

    int NumberOfItems =
        raport.doZeskanowania[Buildings]![Floor]![Room]!.keys.length;
    int NumberOfScannedItems =
        raport.skan[Buildings]![Floor]![Room]!.keys.length;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(bottom: 8),
      child: Text(
          "Suma: ${NumberOfScannedItems.toString()}/${NumberOfItems.toString()}",
          style: const TextStyle(
            fontSize: 30.0,
          )),
    );
  }

  List<Widget> GenerateItems(Report raport, Size rozmiar, String Buildings,
      String Floor, String Room) {
    List<Widget> ret = [];
    for (var items in raport.skan[Buildings]![Floor]![Room]!.keys) {
      ret.add(
        Container(
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          margin: EdgeInsets.only(bottom: 8),
          child: Text(items,
              style: TextStyle(
                fontSize: 20.0,
              )),
        ),
      );
    }
    return ret;
  }

  List<Widget> GenerateRooms(
      Report raport, Size rozmiar, String Building, String Floor) {
    List<Widget> ret = [];
    for (var room in raport.skan[Building]![Floor]!.keys) {
      ret.add(Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(room,
                style: TextStyle(
                  fontSize: 20.0,
                )),
            Container(
              height: 2,
              margin: EdgeInsets.only(bottom: 10),
              color: Colors.black,
            ),
            ...GenerateItems(raport, rozmiar, Building, Floor, room),
            GenerateSummary(raport, rozmiar, Building, Floor, room)
          ],
        ),
      ));
    }
    return ret;
  }

  List<Widget> GenerateFloors(Report raport, Size rozmiar, String Building) {
    List<Widget> ret = [];
    for (var floor in raport.skan[Building]!.keys) {
      ret.add(Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(floor,
                style: TextStyle(
                  fontSize: 15.0,
                )),
            ...GenerateRooms(raport, rozmiar, Building, floor),
          ],
        ),
      ));
    }
    return ret;
  }

  List<Widget> GenerateBuildings(Report raport, Size rozmiar) {
    List<Widget> ret = [];
    print("GENERATE BUILDING");
    print(raport.skan.keys.length);
    for (var building in raport.skan.keys) {
      ret.add(Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(building,
                style: TextStyle(
                  fontSize: 15.0,
                )),
            ...GenerateFloors(raport, rozmiar, building),
          ],
        ),
      ));
    }
    return ret;
  }

  Widget GenerateRaprotContainer(Report raport, Size rozmiar) {
    for (var budynek in raport.skan.keys) {
      print(budynek);
    }

    return Container(
        height: rozmiar.height * 0.7,
        width: rozmiar.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: zielonySGGW),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        //color: Colors.yellow,
        padding: EdgeInsets.all(10.0),
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Raport #" + raport.report_number.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 5),
                child:
                    Text(raport.date_created + " | " + raport.skan.keys.first),
              ),
              Container(
                height: 2,
                color: Colors.black,
              ),
              ...GenerateBuildings(raport, rozmiar),
            ],
          ),
        ));
  }

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
            /// Separotr horyzontalny między guzikami
            SizedBox(
              height: elementsOffset,
            ),

            /// Sekcja odpowiedzialna za wyświetlanie podlgądu skanowania
            Container(
              height: rozmiar.height * 0.55,
              width: rozmiar.width,
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              child:
                  GenerateRaprotContainer(widget.raport, rozmiar) as Container,
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
                      color: lososiowyCzerwony,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Porzuć zmiany",
                      style: TextStyle(
                          fontSize: elementsOffset,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
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
                      widget.raport.zapiszNoweKomentarzeWBazie();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReadyReportPage(
                              numerRaportu: 10, raport: widget.raport , data: dzisiaj)));
                    }
                    raportToDataBase(widget.raport);
                  },
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
