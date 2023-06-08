import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


/// Funkcja zwracająca dwie listy, budynków i numerów budynków;
/// pierwsza zwraca listę list, gdzie każdy element to lista skłądająca się
/// z nazwy budynku i jego identyfikatora, a druga zwraca listę samych numerów
Future pobierzBudynki() async {
  var listaBudynkow = await FirebaseFirestore.instance.collection('Building').get();

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
      .collection("/Building/$wybranyBudynekId/Floors").get();

  List<String> numpietra = [];

  for (var doc in listaPomie.docs) {
    numpietra.add(doc.id.toString());
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
Future<Map<String, Map<String, dynamic>>> pobieraniePrzedmiotow(
    wybranyBudynekId, wybranePietroId, wybranePomId) async {
  var collection = await FirebaseFirestore.instance.collection(
      "/Building/$wybranyBudynekId/Floors/$wybranePietroId/Rooms/$wybranePomId/Items").get();

  print("Kolekcja");
  print(collection);

  Map<String, Map<String, dynamic>> rzeczy = {};

  for (var doc in collection.docs) {
    rzeczy[doc.id] = doc.data();
  }

  return rzeczy;
}
