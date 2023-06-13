import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/add_Item.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/database/globalsClasses.dart';

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: zielonySGGW,
          toolbarHeight: textHeighOffset * 3,
          centerTitle: true,
          title: const Text(
            "Dodaj Typ przedmiotu",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(34),
              bottomRight: Radius.circular(34),
            ),
          ),
        ),
        body: ListView(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: rozmiar.width*0.4,
                  child: ElevatedButton(
                    child: const Text('Dodaj nowy typ przedmiotu'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor:
                      zielonySGGW,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {

                      Version TypeVariant = new Version(controllerVariant.text, controllerDesc.text, controllerProd.text);

                      createItemType(controllerName.text, TypeVariant);
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: rozmiar.width*0.4,
                  child: ElevatedButton(
                    child: const Text('Porzuć dodawanie typu'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor:
                      zielonySGGW,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
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
