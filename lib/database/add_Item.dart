import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:list_picker/list_picker.dart';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'dart:math';

class AddItem extends StatefulWidget {
  final String buildingId;
  final String floorId;
  final String roomId;
  final String itemTypeId;
  final String nameItemType;


  AddItem({
    Key? key,
    required this.buildingId,
    required this.floorId,
    required this.roomId,
    required this.itemTypeId,
    required this.nameItemType,
  }) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class Version{
  String Name;
  String Description;
  String Producer;

  Version(String name, String desc, String prod):
  Name = name,
  Description = desc,
  Producer = prod;

}

class _AddItemState extends State<AddItem> {

  final controllerName = TextEditingController();
  final controllerComment = TextEditingController();

  bool isInit = false;

  List<String> ItemTypes = [];

  String ChosenType = "Typ";

  List<String> Versions = [];

  Map<String, Version> VersionDict = {};

  String ChosenVersion = "Wersja";

  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  Future GetItemTypes() async{
    ItemTypes.clear();
    var snapshot = await FirebaseFirestore.instance.collection("ItemTypes").get();
    for( var i in snapshot.docs ){
      ItemTypes.add(i.id);
    }
    setState(() {});
  }

  Future GetVersions( String Type ) async{
    if( Type == "Typ" ) return;
    Versions.clear();
    VersionDict.clear();
    var snapshot = await FirebaseFirestore.instance.collection("ItemTypes").doc(Type).collection("Wersja").get();
    for( var i in snapshot.docs ){
      var dane = i.data();
      print(i.id);
      print(dane["Opis"]);
      print(dane["Producent"]);
      Versions.add( i.id );
      VersionDict[i.id] = new Version(i.id, dane["Opis"], dane["Producent"]);
    }
  }

  Widget GenerateVersionPicker(double szerokoscPrzycisku, double numberBoxSize){
    if( Versions.length == 0 ) return SizedBox.shrink();
    return  Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: szerokoscPrzycisku,
      height: numberBoxSize,
      child: ElevatedButton(
        style: leftTextActive,
        onPressed: () async {
          String? NewVersion = await showPickerDialog(
            context: context,
            label: "Wersja",
            items: Versions,
          );
          if ((NewVersion != null) && (NewVersion != ChosenType)) {
            ChosenVersion = NewVersion;
            setState(() {});
          }
        },
        child: Text(
          ChosenVersion,
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget GenerateVersionDetails(double szerokoscPrzycisku, double numberBoxSize){
    if( ChosenVersion == "Wersja" ) return SizedBox.shrink();
    return  ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text("Opis",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ))),
        Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(VersionDict[ChosenVersion]!.Description,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 30.0,
            ))),
        Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text("Producent",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ))),
        Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(VersionDict[ChosenVersion]!.Producer,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 30.0,
            )))
      ],
    );
  }


  @override
  Widget build(BuildContext context){

    if ( !isInit ){
      GetItemTypes();
      isInit = true;
    }
    //GetVersions("Biurko");
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
            "Dodaj Przedmiot",
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
              controller: controllerComment,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Dodaj komentarz',
              ),
            ),
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
                    await GetVersions(ChosenType);
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
            GenerateVersionPicker(szerokoscPrzycisku, numberBoxSize),
            GenerateVersionDetails(szerokoscPrzycisku, numberBoxSize),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Dodaj nowy przedmiot'),
              onPressed: () async {
                final item = Item(
                  name: "Przedmiot",
                  comment: controllerComment.text,
                  barcode: next(100000000, 999999999).toString(),
                  datecreated: Timestamp.now(),
                  type: "/ItemTypes/" + ChosenType + "/Wersja/" + ChosenVersion, //ObsoleteFunction
                );

                createItem(item);
                Navigator.pop(context);
              },
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ElevatedButton(
                child: const Text('Porzuć dodawanie przedmiotu'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
  }

  Future createItem(Item item) async {
    final docItem = FirebaseFirestore.instance
        .collection('Building')
        .doc(widget.buildingId)
        .collection('Floors')
        .doc(widget.floorId)
        .collection('Rooms')
        .doc(widget.roomId)
        .collection('Items')
        .doc(item.barcode);
    item.id = docItem.id;

    print(item.id);

    final json = item.toJson();
    print(json);
    await docItem.set(json);

    /*
    await docItem.update({
      'barcode': widget.floorId + '-' + widget.roomId + '-' + widget.item.id,
    });
    */
  }
}
