import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globalsClasses.dart';

class AddItem extends StatelessWidget {
  final String buildingId;
  final String floorId;
  final String roomId;
  final String itemTypeId;
  final String specItemId;

  final String nameItemType;
  final String nameSpecItemType;
  // final String nameItemType;

  AddItem({
    Key? key,
    required this.buildingId,
    required this.floorId,
    required this.roomId,
    required this.itemTypeId,
    required this.specItemId,
    required this.nameItemType,
    required this.nameSpecItemType,
    // required this.nameItemType,
  }) : super(key: key);

  final controllerName = TextEditingController();
  final controllerComment = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add item'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              maxLength: 20,
              controller: controllerName,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            TextField(
              maxLength: 100,
              controller: controllerComment,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                hintText: 'Comment',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Create new item'),
              onPressed: () async {
                final item = Item(
                  name: controllerName.text,
                  comment: controllerComment.text,
                  barcode: '',
                  type: nameItemType + '_' + nameSpecItemType,
                );

                createItem(item);
                Navigator.pop(context); //x4
                // Navigator.popUntil(context, ModalRoute.withName("/edit_room"));
                // Navigator.popUntil(
                //     context, (Route<dynamic> route) => route.isFirst);
              },
            )
          ],
        ),
      );

  Future createItem(Item item) async {
    final docItem = FirebaseFirestore.instance
        .collection('Building')
        .doc(buildingId)
        .collection('Floor')
        .doc(floorId)
        .collection('Rooms')
        .doc(roomId)
        .collection('Item')
        .doc();
    item.id = docItem.id;

    print(item.id);

    final json = item.toJson();
    await docItem.set(json);

    await docItem.update({
      'barcode': floorId + '-' + roomId + '-' + item.id,
    });
  }
}
