import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/custom_app_bar.dart';
import 'package:inventory_app/database/add_Item.dart';
import 'package:inventory_app/database/add_ItemType.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/components/user_input_dialog_simple.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({
    super.key,
    required this.building,
    required this.floor,
    required this.room,
  });
  final String building;
  final String floor;
  final String room;
  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  Map<String, String> itemTypesMap = {};
  List<String> itemTypesList = [];
  bool initalized = false;

  @override
  Widget build(BuildContext context) {
    if (!initalized) {
      getItemTypes();
    }

    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(children: [
        TopBodySection(
            key: UniqueKey(),
            size: mediaSize,
            tekst: "Dodaj",
            location: Location.center),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          width: mediaSize.width * 0.8,
          height: mediaSize.height * 0.6,
          child: ListView.builder(
              itemCount: itemTypesList.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                    title: Text(itemTypesList[index]),
                    children: [
                      for (var key in itemTypesMap.keys.toList())
                        if (itemTypesMap[key] == itemTypesList[index])
                          ListTile(
                            title: Text(key),
                            onTap: () {
                              throw UnimplementedError(); //TODO: To make it work we need to update globalClasses to work for new database formats
                              createItem(widget.building, widget.floor, widget.room, "/itemTypes/${itemTypesList[index]}/$key");
                              Navigator.pop(context);//TODO: It should ask how many items you want to add instead of leaving page
                            },
                          )
                    ]);
              }),
        ),
        GestureDetector(
                onTap: () async{
                  String? itemTypeNew = await showUserInputDialog(
                    context:context,
                    label: "Dodaj typ",
                    );
                    if(itemTypeNew!=null && !itemTypesList.contains(itemTypeNew))
                    {
                      createItemType(itemTypeNew);
                      setState(() {
                        initalized=false;
                      });
                    }
                },
                child: Container(
                width: mediaSize.width * 0.9,
                height: 70.0,
                margin: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: zielonySlabaSGGW,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: const Center(
                child: Text(
                  "Dodaj typ przedmiotu",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
              ),
                ),
              ),
      ]),
    );
  }

  void getItemTypes() async {
    itemTypesMap = await pobranieListyTypow();
    itemTypesList = itemTypesMap.values.map((value) => value).toList();
    itemTypesList = itemTypesList.toSet().toList();
    setState(() {
      itemTypesMap = itemTypesMap;
      itemTypesList = itemTypesList;
      initalized = true;
    });
  }

  Future createItemType(
    String itemType,
  ) async {
    ItemType itemTypeObject = ItemType(name: itemType);
    final docItemType = FirebaseFirestore.instance
        .collection('ItemTypes')
        .doc(itemType);
        
    final json = itemTypeObject.toJson();
    await docItemType.set(json);
    createItemTypeCollection(itemType);
  }

  Future createItemTypeCollection(
    String itemType,
  ) async {
    ItemTypeSpecific itemTypeObject = ItemTypeSpecific(producent: "");
    final docItemType = FirebaseFirestore.instance
        .collection('ItemTypes')
        .doc(itemType)
        .collection('Wersja')
        .doc(itemType+' 1'); 

    final json = itemTypeObject.toJson();
    await docItemType.set(json);
  }

  Future createItem(
    String buildingId,
    String floorId,
    String roomName,
    String itemType,
  ) async {
    Item item = Item(comment: "", name: generateRandomNumberString(), barcode: generateRandomNumberString(), datecreated: Timestamp.now(), type: itemType);
    final docRoom = FirebaseFirestore.instance
        .collection('Building')
        .doc(buildingId)
        .collection('Floors')
        .doc(floorId)
        .collection('Rooms')
        .doc(roomName)
        .collection('Items')
        .doc(item.barcode);

    final json = item.toJson();
    await docRoom.set(json);
  }

  String generateRandomNumberString() { //TODO: Fix to make it generate code in desired format
  Random random = Random();
  String numberString = '';

  for (int i = 0; i < 10; i++) {
    int randomNumber = random.nextInt(10);
    numberString += randomNumber.toString();
  }

  return numberString;
}

}
