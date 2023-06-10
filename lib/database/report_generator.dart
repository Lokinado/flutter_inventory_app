import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  //  Budynek   Pietro   Pomieszczenie   Przedmiot  Komentarz
  Map<String, Map<String, Map<String, Map<String, String>>>> skan = {};

  /// Funkcja służąca do dodawania nowego pomieszczenie do listy zeskanowanych
  /// przyjmuje ona nową lokalizację do dodania i umieszcza ją w zmiennej skan
  Future nowePomieszczenie(budynek, pietro, pomieszczenie) async {
    Map<String, String> miejsce = {};

    final lokalizacja = await FirebaseFirestore.instance
        .collection("/Building/$budynek/Floors/" +
            "$pietro/Rooms/$pomieszczenie/Items/")
        .get();

    for (var s in lokalizacja.docs) {
      miejsce[s.id] = s.data()["comment"];
    }

    skan[budynek]![pietro]![pomieszczenie] = miejsce;
  }

  /// Funkcja która jest wywoływana przy przejściu do skanowania nowego
  /// pomieszczenia - zapisuje zmiany wprowadzone przez użytkownika do raportu
  Future wpiszNoweZmiany(budynek, pietro, pomieszczenie,
      Map<String, Map<String, String>> dane) async {
    for(String typ in dane.keys){
      for(String barcode in dane[typ]!.keys){
        skan[budynek]![pomieszczenie]![pietro]![barcode] = dane[typ]![barcode]!;
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
                .set({
              "comment": skan[budynek]![pietro]![pomieszczenie]!["comment"],
            });
          }
        }
      }
    }
  }
}
