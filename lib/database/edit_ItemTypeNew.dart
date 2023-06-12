/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/list_SpecificItemTypes.dart';

import 'add_SpecificItemTypes.dart';
// import 'package:inventory_app/add_Floor.dart';
// import 'list_Floors.dart';

class EditItemType extends StatelessWidget {
  final String buildingId;
  final String floorId;
  final String roomId;

  final String name;
  final String itemTypeId;
  EditItemType({
    Key? key,
    required this.buildingId,
    required this.floorId,
    required this.roomId,
    required this.name,
    required this.itemTypeId,
  }) : super(key: key);

  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit item type: $name'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // print('kruwa');
            // print(itemTypeId);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddSpecificItemType(
                  itemTypeId: itemTypeId,
                ),
              ),
            );
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 80,
                width: 240,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Name: $name \nID: $itemTypeId',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              maxLength: 20,
              controller: controllerName,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () async {
                // print(itemTypeId);

                final docItemType = FirebaseFirestore.instance
                    .collection('ItemTypes')
                    .doc(itemTypeId);
                docItemType.update({
                  'name':
                      (controllerName.text == '' ? name : controllerName.text),
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
            // DisplayFloors(buildingId: itemTypeId),
            DisplaySpecificItemType(
              itemTypeId: itemTypeId,
              buildingId: buildingId,
              floorId: floorId,
              roomId: roomId,
              nameItemType: name,
            )
          ],
        ),
      );
}
 */