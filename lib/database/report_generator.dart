import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'dart:math';

class Report {
  //  Budynek   Pietro   Pomieszczenie   Przedmiot  Komentarz
  Map<String, Map<String, Map<String, Map<String, String>>>> skan = {};
  Map<String, Map<String, Map<String, Map<String, String>>>> doZeskanowania =
      {};
  String date_created;
  int report_number;

  // Map<String, Map<String, Map<String, String>>> skan2 = {};

  //

  final _random = new Random(); // ZARAZ WRACAM

  Report()
      : date_created =
            '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
        report_number = 0 {
    report_number = next(100000, 999999);
  }

  Report.fromData(inskan, indoZeskanowania, indate_created, inreport_number)
      : date_created = indate_created,
        skan = inskan,
        doZeskanowania = indoZeskanowania,
        report_number = int.parse(inreport_number) ;

  int next(int min, int max) => min + _random.nextInt(max - min);

// funkcja to json

  // Map<String, Map<String, Map<String, Map<String, Map<String, String>>>>>
  //     toJson() => {
  //           "value": skan,
  //           "report_number": report_number.toString(),
  //         };

  Map<String, dynamic> toJson() => {
        "zeskanowane": skan,
        "oczekiwane": doZeskanowania,
        "report_number": report_number.toString(),
        "date_created": date_created,
      };

  void fromJson(Map<String, dynamic> json) {
  if (json.containsKey('zeskanowane')) {
    skan = parseMap((json['zeskanowane']));
  }
  if (json.containsKey('oczekiwane')) {
    doZeskanowania = parseMap(json['oczekiwane']);
  }
  if (json.containsKey('date_created')) {
    date_created = json['date_created'].toString();
  }
  if (json.containsKey('report_number')) {
    report_number = int.parse(json['report_number'].toString());
  }
}

  /// Funkcja służąca do dodawania nowego pomieszczenie do listy zeskanowanych
  /// przyjmuje ona nową lokalizację do dodania i umieszcza ją w zmiennej skan
  Future nowePomieszczenie(budynek, pietro, pomieszczenie) async {
    if (!skan.containsKey(budynek)) {
      Map<String, Map<String, Map<String, String>>> pietra = {};
      Map<String, Map<String, Map<String, String>>> pietraDZ = {};
      skan[budynek] = pietra;
      doZeskanowania[budynek] = pietraDZ;
    }
    if (!skan[budynek]!.containsKey(pietro)) {
      Map<String, Map<String, String>> pomiesz = {};
      Map<String, Map<String, String>> pomieszDZ = {};
      skan[budynek]![pietro] = pomiesz;
      doZeskanowania[budynek]![pietro] = pomieszDZ;
    }
    if (!skan[budynek]![pietro]!.containsKey(pomieszczenie)) {
      Map<String, String> przed = {};
      Map<String, String> przedDZ = {};
      skan[budynek]![pietro]![pomieszczenie] = przed;
      doZeskanowania[budynek]![pietro]![pomieszczenie] = przedDZ;
    }

    Map<String, Map<String, dynamic>> result =
        await pobieraniePrzedmiotow(budynek, pietro, pomieszczenie);
    doZeskanowania[budynek]![pietro]![pomieszczenie] = {};
    for (var key in result.keys) {
      doZeskanowania[budynek]![pietro]![pomieszczenie]![key] = "OK";
    }
    // print("ROZM");
    // print(doZeskanowania[budynek]![pietro]![pomieszczenie]!.keys.length);
  }

  /// Funkcja która jest wywoływana przy przejściu do skanowania nowego
  /// pomieszczenia - zapisuje zmiany wprowadzone przez użytkownika do raportu
  Future wpiszNoweZmiany(budynek, pietro, pomieszczenie,
      Map<String, Map<String, String>> dane) async {
    for (String typ in dane.keys) {
      for (String barcode in dane[typ]!.keys) {
        Map<String, String> miejsce = {};
        miejsce[barcode] = dane[typ]![barcode]!;
        skan[budynek]![pietro]![pomieszczenie]![barcode] = dane[typ]![barcode]!;
      }
    }
  }

  /// Metoda do wywołania na koniec raportu.
  /// Pozwala ona uaktualnić bazę danych, o wpisanie na stałe komentarzy
  /// które użytkownik dodał przy wpisywaniu przedmiotów
  Future zapiszNoweKomentarzeWBazie() async {
    // Dla każdego budynku ...
    for (var budynek in skan.keys) {
      // ... dla każdego piętra ...
      for (var pietro in skan[budynek]!.keys) {
        // ... dla każdego pomieszczenia ...
        for (var pomieszczenie in skan[budynek]![pietro]!.keys) {
          // ... dla każdego przedmiotu ...
          for (var przedmiot in skan[budynek]![pietro]![pomieszczenie]!.keys) {
            // ... zapisz w bazie jego nowy komentarz
            await FirebaseFirestore.instance
                .collection("/Building/$budynek" +
                    "/Floors/$pietro/Rooms/$pomieszczenie/Items")
                .doc(przedmiot)
                .update({
              "comment": skan[budynek]![pietro]![pomieszczenie]!["comment"],
            });
          }
        }
      }
    }
  }

  //FirebaseFirestore.instance.collection().set(/aushopd)

  /// Wypełnia tablicę do zeskanowania w danej instancji raportu
  /// na podstawie tych danych potem przeprowadzone zostanie porównanie czego brakuje
  Future PobierzWszystkiePrzedmiotyZePietra() async {
    print("CODE RUNS");
    String budynek = skan.keys.first;
    doZeskanowania[budynek] = {};
    List<String> floors = await pobierzPietra(budynek);
    for (var floor in floors) {
      List<String> rooms = await pobierzPomieszczenia(budynek, floor);
      doZeskanowania[budynek]![floor] = {};
      for (var room in rooms) {
        Map<String, Map<String, dynamic>> result =
            await pobieraniePrzedmiotow(budynek, floor, room);
        doZeskanowania[budynek]![floor]![room] = {};
        for (var key in result.keys) {
          print("OK I ADD " + key);
          print("OK I ADD " + result[key].toString());
          doZeskanowania[budynek]![floor]![room]![key] = "OK";
        }
        print("ROZM");
        print(doZeskanowania[budynek]![floor]![room]!.keys.length);
      }
    }
  }
}
