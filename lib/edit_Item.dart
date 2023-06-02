import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  final String name;
  final String roomId;
  final String floorId;
  final String itemTypeId;
  final String itemTypeName;
  final String itemId;
  final String comment;

  final String barcode;

  EditItem({
    Key? key,
    required this.name,
    required this.roomId,
    required this.floorId,
    required this.itemTypeId,
    required this.itemTypeName,
    required this.itemId,
    required this.comment,
    required this.barcode,
  }) : super(key: key);

  final controllerComment = TextEditingController();
  final controllerName = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit item: $name'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 190,
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
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Name: $name \nID: $itemId \nComment: $comment\nBarcode: \n$barcode',
                      style: TextStyle(fontSize: 20),
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
            TextField(
              controller: controllerComment,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Comment',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: Text('Update Item'),
              onPressed: () async {
                final docUser = FirebaseFirestore.instance
                    .collection('Floor')
                    .doc(floorId)
                    .collection('Rooms')
                    .doc(roomId)
                    .collection('ItemTypes')
                    .doc(itemTypeId)
                    .collection('Item')
                    .doc(itemId);
                // Update user
                docUser.update({
                  'name':
                      (controllerName.text == '' ? name : controllerName.text),
                  'comment': (controllerComment.text == ''
                      ? comment
                      : controllerComment.text),
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
}
