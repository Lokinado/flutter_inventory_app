import 'package:cloud_firestore/cloud_firestore.dart';

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
  for (var k in typy.values){
    przedmiotyWgKat[k] = {};
  }

  // Przydzialanie przedmiotów do kategorii
  for (var p in przedmioty.keys){
    var item = przedmioty[p];
    var indexKat = item!["typ"].toString().split("/").length;
    var kat = item!["typ"].toString().split("/")[indexKat-1];
    przedmiotyWgKat[typy![kat].toString()]![p] = przedmioty[p]!["comment"].toString();
  }

  return przedmiotyWgKat;
}
