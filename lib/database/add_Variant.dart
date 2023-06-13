import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/add_Item.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:list_picker/list_picker.dart';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'dart:math';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/custom_app_bar.dart';

class AddVariant extends StatefulWidget {

  @override
  State<AddVariant> createState() => _AddVariantState();
}

class _AddVariantState extends State<AddVariant> {

  final controllerVariant = TextEditingController();
  final controllerDesc = TextEditingController();
  final controllerProd = TextEditingController();

  bool isInit = false;

  List<String> ItemTypes = [];

  String ChosenType = "Typ";

  Future GetItemTypes() async{
    ItemTypes.clear();
    var snapshot = await FirebaseFirestore.instance.collection("ItemTypes").get();
    for( var i in snapshot.docs ){
      ItemTypes.add(i.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context){

    if ( !isInit ){
      GetItemTypes();
      isInit = true;
    }
    final Size rozmiar = MediaQuery.of(context).size;
    var textHeighOffset = rozmiar.height * 0.04;
    var szerokoscPrzycisku = rozmiar.width - 120;
    double numberBoxSize = 60;

    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          TopBodySection(key: UniqueKey(), size: rozmiar, tekst: "Dodaj Wariant Przedmiotu", location: Location.center),
          Container(
            height: rozmiar.height * 0.8,
            child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: szerokoscPrzycisku,
                height: numberBoxSize,
                child: ElevatedButton(
                  style: leftTextActive,
                  onPressed: () async {
                    String? NewSelectedType = await showPickerDialog(
                      context: context,
                      label: "Typ",
                      items: ItemTypes,
                    );
                    if ((NewSelectedType != null) && (NewSelectedType != ChosenType)) {
                      ChosenType = NewSelectedType;
                      setState(() {});
                    }
                  },
                  child: Text(
                    ChosenType,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: rozmiar.width*0.4,
                    child: ElevatedButton(
                      child: const Text('Dodaj nową wersję'),
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
                
                        createVersion(TypeVariant);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: rozmiar.width*0.4,
                    child: ElevatedButton(
                      child: const Text('Porzuć dodawanie wersji'),
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
          ),]
      ),
    );
  }

  Future createVersion(Version Variant) async {
    final docVariant = FirebaseFirestore.instance
        .collection('ItemTypes')
        .doc(ChosenType)
        .collection("Wersja")
        .doc(Variant.Name);

    final json = Variant.toJson();
    print(json);
    await docVariant.set(json);

    /*
    await docItem.update({
      'barcode': widget.floorId + '-' + widget.roomId + '-' + widget.item.id,
    });
    */
  }
}
