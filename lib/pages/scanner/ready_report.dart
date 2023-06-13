import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:inventory_app/database/list_Floors.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:inventory_app/database/report_generator.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/database/listing_items.dart';
import 'package:inventory_app/pages/scanner/finish_report.dart';

@immutable // zalecane dla wydajności - podpowiedz ide
class ReadyReportPage extends StatelessWidget {
   ReadyReportPage({Key? key, required this.numerRaportu, required this.data, required this.raport}) : super(key: key);

  final int numerRaportu; /// Numer raportu przekazany z zewnątrz
  late String data; /// Data raportu przekazana z zewnątrz
  late Report raport;

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
        backgroundColor: zielonySGGW,
        toolbarHeight: textHeighOffset * 2 + textHeighOffset,
        centerTitle: true,
        title: SizedBox(
          height: elementsOffset*3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Raport ${numerRaportu}",
                style: TextStyle(fontSize: textHeighOffset*0.75, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: elementsOffset*0.3,),
              Text(
                "${data}",
                style: TextStyle(fontSize: textHeighOffset*0.4, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(34),
            bottomRight: Radius.circular(34),
          ),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: rozmiar.height*0.01,
          ),
          GenerateRaprotContainer(
            raport,
            MediaQuery.of(context).size,
          ),
          SizedBox(
            height: rozmiar.height*0.01,
          ),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop("reset");
              },
              child: Container(
                height: elementsOffset * 4,
                width: rozmiar.width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: zielonySlabaSGGW,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Powrót na stronę główną",
                  style: TextStyle(
                      fontSize: elementsOffset,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}

Widget GenerateRaprotContainer(Report raport, Size rozmiar) {
  for (var budynek in raport.skan.keys) {
    print(budynek);
  }

  return Container(

      height: rozmiar.height *0.7,
      width: rozmiar.width*1,
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: zielonySGGW),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      //color: Colors.yellow,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(6),
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
              child: Text(raport.date_created + " | " + raport.skan.keys.first),
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

List<Widget> GenerateItems(
    Report raport, Size rozmiar, String Buildings, String Floor, String Room) {
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