import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/database/globalsClasses.dart';


int znajdzNaLiscie(List lista, wartosc){
  for(int i = 0; i < lista.length; i++){
    if (lista[i][0].contains(wartosc)){
      return i;
    }
  }
  return -1;
}

Future pobierzBudynki() async {

  var collection = FirebaseFirestore.instance.collection('Building');
  var querySnapshot = await collection.get();

  List<List<String>> bud = [];
  List<String> lisbud = [];

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data();
    String budynek = data['name'];
    String id = data['id'];
    List<String> lista = [budynek, id];
    bud.add(lista);
    lisbud.add(budynek);
  }

  return [bud, lisbud];

}

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
    String pietro = data['name'];
    String id = data['id'];
    List<String> lista = [pietro, id];
    pietra.add(lista);
    numpietra.add(pietro);
  }
  return [pietra, numpietra];
}

Future<List<dynamic>> pobierzPomieszczenia(wybranyBudynekId, wybranePietroId) async {
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
    String pomieszczenie = data['name'];
    String id = data['id'];
    List<String> lista = [pomieszczenie, id];
    pom.add(lista);
    numPom.add(pomieszczenie);
  }

  return [pom, numPom];
}