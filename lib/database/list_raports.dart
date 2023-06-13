import 'package:flutter/material.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:inventory_app/database/list_Floors.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:inventory_app/database/report_generator.dart';
import '../components/color_palette.dart';
import 'listing_items.dart';
import 'package:inventory_app/pages/scanner/finish_report.dart';

class ListRaports extends StatefulWidget {
  @override
  _ListRaportsState createState() => _ListRaportsState();
}

class _ListRaportsState extends State<ListRaports> {
  String? selectedRaportId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          child: FutureBuilder<dynamic>(
            future: pobierzRaporty(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Something went wrong: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final raports = snapshot.data!;

                return Column(
                  children: [
                    if (selectedRaportId == null)
                      Expanded(
                        child: ListView.builder(
                          itemCount: raports.length,
                          itemBuilder: (context, index) {
                            final raport = raports[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RaportDetailsPage(raportId: raport),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Raport $raport',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class RaportDetailsPage extends StatelessWidget {
  final String raportId;

  RaportDetailsPage({required this.raportId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Szczegóły Raport $raportId'),
          toolbarHeight: 60,
          backgroundColor: zielonySGGW, // Zmiana koloru na zielony
          leading: IconButton( // Dodanie strzałki powrotnej
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Powrót do poprzedniego ekranu
            },
          ),
        ),
      body: FutureBuilder<Report>(
        future: pobierzRaportjson(raportId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Something went wrong: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final raport = snapshot.data!;
            print("raport do zeskanowania");
            print(raport.doZeskanowania);

            return Column(
              children: [
                GenerateRaprotContainer(
                  raport,
                  MediaQuery.of(context).size,
                ),
                
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}



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
  
      height: rozmiar.height *0.88,
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
