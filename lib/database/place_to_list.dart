import 'package:cloud_firestore/cloud_firestore.dart';


/// Funkcja zwracająca dwie listy, budynków i numerów budynków;
/// pierwsza zwraca listę list, gdzie każdy element to lista skłądająca się
/// z nazwy budynku i jego identyfikatora, a druga zwraca listę samych numerów
Future pobierzBudynki() async {
  var listaBudynkow = await FirebaseFirestore.instance.collection('Building').get();

  List<String> lisbud = [];

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data();
    String budynek = data['Nazwa'];
    String id = data['Nazwa'];
    List<String> lista = [budynek, id];
    bud.add(lista);
    lisbud.add(budynek);
  }

  return lisbud;
}

/// Funkcja pobierająca informację o wybranym budynku, i zwracająca tablicę
/// napisów reprezentujących numerów pięter (przygotowanie na nr. piętra z lierą)
Future pobierzPietra(wybranyBudynekId) async {
  var listaPomie = await FirebaseFirestore.instance
      .collection("/Building/$wybranyBudynekId/Floors").get();

  List<String> numpietra = [];

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data();
    String pietro = data['Nazwa'];
    String id = data['Nazwa'];
    List<String> lista = [pietro, id];
    pietra.add(lista);
    numpietra.add(pietro);
  }

  return numpietra;
}

/// Funkcja pobierająca informację o wybranym budynku i piętrze, a zwracająca
/// listę pomieszczeń, w tym budynku, na tym piętrze
Future pobierzPomieszczenia(
    wybranyBudynekId, wybranePietroId) async {
  var listaPom = await FirebaseFirestore.instance
      .collection("/Building/$wybranyBudynekId/Floors/$wybranePietroId/Rooms").get();

  List<String> numPom = [];

  for (var doc in listaPom.docs) {
    numPom.add(doc.id.toString());
  }

  return numPom;
}

/// Funkcja pobierająca informacj o lokaliczacji pomieszczenia i zwracająca
/// tablicę elementów znajdujących się w tym pomieszczeniu
Future pobieraniePrzedmiotow(
    wybranyBudynekId, wybranePietroId, wybranePomId) async {
  var collection = await FirebaseFirestore.instance.collection(
      "/Building/$wybranyBudynekId/Floor/$wybranePietroId/Rooms/$wybranePietroId");

  var querySnapshot = await collection.get();

  List<List<String>> pom = [];

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data();
    String pomieszczenie = data['Nazwa'];
    String id = data['Nazwa'];
    List<String> lista = [pomieszczenie, id];
    pom.add(lista);
    numPom.add(pomieszczenie);
  }
  print(pom);
}
