import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  //  Budynek   Pietro   Pomieszczenie   Przedmiot  Komentarz
  Map<String, Map<String, Map<String, Map<String, String>>>> skan = {};

  /// Funkcja służąca do dodawania nowego pomieszczenie do listy zeskanowanych
  /// przyjmuje ona nową lokalizację do dodania i umieszcza ją w zmiennej skan
  Future nowePomieszczenie(budynek, pietro, pomieszczenie) async {
    if (!skan.containsKey(budynek)){
      Map<String,Map<String, Map<String, String>>> pietra = {};
      skan[budynek] = pietra;
    }
    if (!skan[budynek]!.containsKey(pietro)){
      Map<String, Map<String, String>> pomiesz = {};
      skan[budynek]![pietro] = pomiesz;
    }
    if (!skan[budynek]![pietro]!.containsKey(pomieszczenie)){
      Map<String, String> przed = {};
      skan[budynek]![pietro]![pomieszczenie] = przed;
    }
  }

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
