import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'materials.dart';

class AddItemType extends StatelessWidget {
  final String floorId;
  final String roomId;

  AddItemType({
    Key? key,
    required this.floorId,
    required this.roomId,
  }) : super(key: key);

  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add item type'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Create new item type'),
              onPressed: () async {
                final itemType = ItemType(
                  name: controllerName.text,
                );

                createItemType(itemType);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

  Future createItemType(ItemType itemType) async {
    final docItemType = FirebaseFirestore.instance
        .collection('Floor')
        .doc(floorId)
        .collection('Rooms')
        .doc(roomId)
        .collection('ItemTypes')
        .doc();
    itemType.id = docItemType.id;

    final json = itemType.toJson();
    await docItemType.set(json);
  }
}
