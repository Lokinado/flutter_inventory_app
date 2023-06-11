import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Report {
  //  Budynek   Pietro   Pomieszczenie   Przedmiot  Komentarz
  Map<String, Map<String, Map<String, Map<String, String>>>> skan = {};

  String date_created;
  int report_number;

  final _random = new Random();
  /// Funkcja która jest wywoływana przy przejściu do skanowania nowego
  /// pomieszczenia - zapisuje zmiany wprowadzone przez użytkownika do raportu
  Future wpiszNoweZmiany(budynek, pietro, pomieszczenie,
      Map<String, Map<String, String>> dane) async {
    for(String typ in dane.keys){
      for(String barcode in dane[typ]!.keys){
        Map<String, String> miejsce = {};
        miejsce[barcode] = dane[typ]![barcode]!;
        skan[budynek]![pietro]![pomieszczenie]![barcode] = dane[typ]![barcode]!;
      }
    }
  }

  Report()
    :date_created = '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
    report_number = 0
  {
    report_number = next(100000, 999999);

  int next(int min, int max) => min + _random.nextInt(max - min);
  
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
}
