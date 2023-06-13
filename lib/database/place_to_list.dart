import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/database/report_generator.dart';

/// Funkcja zwracająca dwie listy, budynków i numerów budynków;
/// pierwsza zwraca listę list, gdzie każdy element to lista skłądająca się
/// z nazwy budynku i jego identyfikatora, a druga zwraca listę samych numerów
Future pobierzBudynki() async {
  var listaBudynkow =
      await FirebaseFirestore.instance.collection('Building').get();

  List<String> lisbud = [];

  for (var doc in listaBudynkow.docs) {
    lisbud.add(doc.id.toString());
  }

  return lisbud;
}

Future pobierzRaporty() async {
  var listaRaportow =
      await FirebaseFirestore.instance.collection('ReportsData').get();

  List<String> lisrap = [];

  for (var doc in listaRaportow.docs) {
    lisrap.add(doc.id.toString());
  }
  return lisrap;
}

// Future<List<dynamic>> pobieranieRaportow() async {
//   var collection =
//       await FirebaseFirestore.instance.collection('ReportsData').get();

//   List<dynamic> rzeczy = [];

//   for (var doc in collection.docs) {
//     rzeczy.add(doc.data());
//   }
//   print(rzeczy);
//   print(rzeczy[0]);
//   print(rzeczy[1]);
//   return rzeczy;
// }

// class DaneRaportu {
//   String dateCreated;
//   Map<String, Map<String, Map<String, Map<String, String>>>> oczekiwane;
//   String reportNumber;
//   Map<String, Map<String, Map<String, Map<String, String>>>> zeskanowane;

//   DaneRaportu({
//     required this.dateCreated,
//     required this.oczekiwane,
//     required this.reportNumber,
//     required this.zeskanowane,
//   });
//   @override
//   String toString() {
//     return reportNumber;
//   }
// }

// Future<DaneRaportu> pobierzRaport(String raportID) async {
//   DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//       .instance
//       .collection('ReportsData')
//       .doc(raportID)
//       .get();
//   Map<String, dynamic> dane = snapshot.data() as Map<String, dynamic>;
//   print("pierwsze");
//   print(dane);
//   DaneRaportu raport = await konwertujNaDaneRaportu(dane);
//   return raport;
// }


Map<String, Map<String, Map<String, Map<String, String>>>> parseMap(Map<String, dynamic> data) {
  Map<String, Map<String, Map<String, Map<String, String>>>> result = {};

  data.forEach((outerKey, outerValue) {
    if (outerValue is Map<String, dynamic>) {
      Map<String, Map<String, Map<String, String>>> innerMap = {};

      outerValue.forEach((innerKey, innerValue) {
        if (innerValue is Map<String, dynamic>) {
          Map<String, Map<String, String>> innermostMap = {};

          innerValue.forEach((innermostKey, innermostValue) {
            if (innermostValue is Map<String, dynamic>) {
              Map<String, String> innermostmostMap = {};

              innermostValue.forEach((innermostmostKey, innermostmostValue) {
                if (innermostmostValue is String) {
                  innermostmostMap[innermostmostKey] = innermostmostValue;
                }
              });

              innermostMap[innermostKey] = innermostmostMap;
            }
          });

          innerMap[innerKey] = innermostMap;
        }
      });

      result[outerKey] = innerMap;
    }
  });

  return result;
}


Future<Report> pobierzRaportjson(String raportID) async {
  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('ReportsData')
      .doc(raportID)
      .get();
  Map<String, dynamic> dane = snapshot.data() as Map<String, dynamic>;
  print("pierwsze");
  print(dane);
  Report raport = new Report();
  print(raport);
  raport.fromJson(dane);
  print(raport);
  print("pobrane z bazy");
  print(raport.date_created);
  print(raport.report_number);
  print(raport.doZeskanowania);
  print("po pobraniu");
  return raport;
} 

// Future<DaneRaportu> konwertujNaDaneRaportu(Map<String, dynamic> dane) async {
//   String dateCreated = dane['date_created'];
//   String reportNumber = dane['report_number'];

//   Map<String, dynamic> oczekiwane = dane['oczekiwane'];
//   print("danejebane");
//   print(dane['oczekiwane'].toString());

//   Map<String, dynamic> zeskanowane = dane['zeskanowane'];

//   DaneRaportu raport = DaneRaportu(
//     dateCreated: dateCreated,
//     oczekiwane: oczekiwane
//         .cast<String, Map<String, Map<String, Map<String, String>>>>(),
//     reportNumber: reportNumber,
//     zeskanowane: zeskanowane
//         .cast<String, Map<String, Map<String, Map<String, String>>>>(),
//   );
//   print(raport);
//   return raport;
// }

// Future PobieranieDanychzRaportu(RaportID) async {
// // Pobranie danych z bazy danych
//   DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//       .instance
//       .collection('ReportsData')
//       .doc('$RaportID')
//       .get();
//   print(snapshot);
// // Mapowanie danych na instancję klasy modelu
//   DaneRaportu daneRaportu = DaneRaportu(
//     dateCreated: snapshot['date_created'],
//     oczekiwane: snapshot['oczekiwane'],
//     reportNumber: snapshot['report_number'],
//     zeskanowane: snapshot['zeskanowane'],
//   );

// // Teraz możesz uzyskać dostęp do pól obiektu tak jak do innych obiektów
//   print(daneRaportu.dateCreated);
//   print(daneRaportu.oczekiwane);
//   print(daneRaportu.reportNumber);
//   print(daneRaportu.zeskanowane);
//   return daneRaportu;
// }

/// Funkcja pobierająca informację o wybranym budynku, i zwracająca tablicę
/// napisów reprezentujących numerów pięter (przygotowanie na nr. piętra z lierą)
Future pobierzPietra(wybranyBudynekId) async {
  var listaPomie = await FirebaseFirestore.instance
      .collection("/Building/$wybranyBudynekId/Floors")
      .get();

  List<String> numpietra = [];

  for (var doc in listaPomie.docs) {
    numpietra.add(doc.id.toString());
  }

  return numpietra;
}

/// Funkcja pobierająca informację o wybranym budynku i piętrze, a zwracająca
/// listę pomieszczeń, w tym budynku, na tym piętrze
Future pobierzPomieszczenia(wybranyBudynekId, wybranePietroId) async {
  var listaPom = await FirebaseFirestore.instance
      .collection("/Building/$wybranyBudynekId/Floors/$wybranePietroId/Rooms")
      .get();

  List<String> numPom = [];

  for (var doc in listaPom.docs) {
    numPom.add(doc.id.toString());
  }

  return numPom;
}

/// Funkcja pobierająca informacj o lokaliczacji pomieszczenia i zwracająca
/// tablicę elementów znajdujących się w tym pomieszczeniu
Future<Map<String, Map<String, dynamic>>> pobieraniePrzedmiotow(
    wybranyBudynekId, wybranePietroId, wybranePomId) async {
  var collection = await FirebaseFirestore.instance
      .collection(
          "/Building/$wybranyBudynekId/Floors/$wybranePietroId/Rooms/$wybranePomId/Items")
      .get();

  Map<String, Map<String, dynamic>> rzeczy = {};

  for (var doc in collection.docs) {
    rzeczy[doc.id] = doc.data();
  }

  return rzeczy;
}

/// Funkcja pobierająca informacje nt. tego jakie mamy typy przemdiotów i
/// zwracająca listę, dla którem mamy przypisany ogólny typ dla każdego
/// przedmiotu z osobana: {K2 : "Krzesło" , B& : "Biurko" ... }
Future<Map<String, String>> pobranieListyTypow() async {
  var przedmioty =
      await FirebaseFirestore.instance.collection("ItemTypes").get();

  Map<String, String> elemTyp = {};

  /// Utworzenie listy typów
  for (var prze in przedmioty.docs) {
    var wersje = await FirebaseFirestore.instance
        .collection("ItemTypes/${prze.id}/Wersja")
        .get();
    for (var odmiana in wersje.docs) {
      elemTyp[odmiana.id] = prze.id;
    }
  }

  return elemTyp;
}

Future<Map<String, Map<String, String>>> przedmiotyWKategoriach(
    budId, pieId, pomId) async {
  Map<String, String> typy = await pobranieListyTypow();

  Map<String, Map<String, dynamic>> przedmioty =
      await pobieraniePrzedmiotow(budId, pieId, pomId);

  Map<String, Map<String, String>> przedmiotyWgKat = {};

  // Utworzenie gotowych kategorii
  for (var k in typy.values) {
    przedmiotyWgKat[k] = {};
  }

  // Przydzialanie przedmiotów do kategorii
  for (var p in przedmioty.keys) {
    var item = przedmioty[p];
    var indexKat = item!["typ"].toString().split("/").length;
    var kat = item!["typ"].toString().split("/")[indexKat - 1];
    przedmiotyWgKat[typy![kat].toString()]![p] =
        przedmioty[p]!["comment"].toString();
  }

  return przedmiotyWgKat;
}
