import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/add_Item.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:inventory_app/components/custom_app_bar.dart';
import 'package:inventory_app/components/topbodysection.dart';

class AddItemType extends StatelessWidget {

  final controllerName = TextEditingController();
  final controllerVariant = TextEditingController();
  final controllerDesc = TextEditingController();
  final controllerProd = TextEditingController();


  @override
  Widget build(BuildContext context){
    final Size rozmiar = MediaQuery.of(context).size;
    var textHeighOffset = rozmiar.height * 0.04;
    var szerokoscPrzycisku = rozmiar.width - 120;
    double numberBoxSize = 60;
    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: [
            TopBodySection(key: UniqueKey(), size: rozmiar, tekst: "Dodaj typ przedmiotu", location: Location.center
            ),
            Container(
              height: 400,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  TextField(
                    controller: controllerName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Podaj nazwę typu',
                    ),
                  ),
                  TextField(
                    controller: controllerVariant,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Podaj nazwę wersji przedmiotu',
                    ),
                  ),
                  TextField(
                    controller: controllerDesc,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Podaj opis dla wersji',
                    ),
                  ),
                  TextField(
                    controller: controllerProd,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Podaj producenta dla wersji',
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    child: const Text('Create new item type'),
                    onPressed: () async {
            
                      Version TypeVariant = new Version(controllerVariant.text, controllerDesc.text, controllerProd.text);
            
                      createItemType(controllerName.text, TypeVariant);
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                      child: const Text('Porzuć dodawanie typu'),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
            
              ),
            ),
          ],
        ),
      );
  }
  Future createItemType(String TypeName, Version Variant) async {
    await FirebaseFirestore.instance
        .collection('ItemTypes')
        .doc(TypeName).set({});

    final docItemType = await FirebaseFirestore.instance
        .collection('ItemTypes')
        .doc(TypeName)
        .collection("Wersja")
        .doc(Variant.Name);

    final json = Variant.toJson();
    await docItemType.set(json);
  }

}
