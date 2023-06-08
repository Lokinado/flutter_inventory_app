/// Ten plik jest odpowiedzialny za pobieranie informacji nt budynków, pięter
/// lub sal - pobrane wyniki są zwracane jako listy danych
/// zostaje on użyty w pick_place_page.dart i change_place_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';

/// Funkcja znajduąca indeks danego elementu na liście, wiedząc którą listę
/// trzeba przejrzeć, i jaki numer jest szukany
int znajdzNaLiscie(List lista, wartosc) {
  for (int i = 0; i < lista.length; i++) {
    if (lista[i][0].contains(wartosc)) {
      return i;
    }
  }
  return -1;
}

/// Funkcja zwracająca dwie listy, budynków i numerów budynków;
/// pierwsza zwraca listę list, gdzie każdy element to lista skłądająca się
/// z nazwy budynku i jego identyfikatora, a druga zwraca listę samych numerów
Future pobierzBudynki() async {
  var collection = FirebaseFirestore.instance.collection('Building');
  var querySnapshot = await collection.get();

  List<List<String>> bud = [];
  List<String> lisbud = [];

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data();
    String budynek = data['Nazwa'];
    String id = data['Nazwa'];
    List<String> lista = [budynek, id];
    bud.add(lista);
    lisbud.add(budynek);
  }

  // to ma zwracać listę z dwoma listami
  // pierwsza lista (bud) przechowuje listy obu produktów
  // [ ["30" , "u092y4tqhasfda9hg4hv"] , ["12", "q7byv3tw97ybvaycbq8"] ... ]
  // druga (lisbud) przechowuje tylko kolejne numery
  // [ "30" , "12" ...]
  return [bud, lisbud];
}

/// Funkcja pobierająca informację o wybranym piętrze, i zwracająca dwie
/// listy z informacjami nt. kolejnych pięter
Future<List<dynamic>> pobierzPietra(wybranyBudynekId) async {
  var collection = FirebaseFirestore.instance
      .collection('Building')
      .doc(wybranyBudynekId)
      .collection('Floor');
  var querySnapshot = await collection.get();

  List<List<String>> pietra = [];
  List<String> numpietra = [];

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data();
    String pietro = data['Nazwa'];
    String id = data['Nazwa'];
    List<String> lista = [pietro, id];
    pietra.add(lista);
    numpietra.add(pietro);
  }
  // podobnie jak w  funkcji o budynkach
  return [pietra, numpietra];
}

/// Funkcja pobierając informacje nt. pomieszczeń, znajdujących się w danym
/// budynku, na danym piętrze
Future<List<dynamic>> pobierzPomieszczenia(
    wybranyBudynekId, wybranePietroId) async {
  var collection = FirebaseFirestore.instance
      .collection('Building')
      .doc(wybranyBudynekId)
      .collection('Floors')
      .doc(wybranePietroId)
      .collection('Rooms');
  var querySnapshot = await collection.get();

  List<dynamic> pom = [];
  List<dynamic> numPom = [];

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data();
    String pomieszczenie = data['Nazwa'];
    String id = data['Nazwa'];
    List<String> lista = [pomieszczenie, id];
    pom.add(lista);
    numPom.add(pomieszczenie);
  }
  // tak jak przy poprzednich funkcjach
  return [pom, numPom];
}
