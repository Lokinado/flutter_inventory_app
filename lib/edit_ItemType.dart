import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_Item.dart';
import 'list_Items.dart';

class EditItemType extends StatelessWidget {
  final String name;
  final String roomId;
  final String floorId;
  final String itemTypeId;

  EditItemType({
    Key? key,
    required this.name,
    required this.roomId,
    required this.floorId,
    required this.itemTypeId,
  }) : super(key: key);

  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit item type: $name'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddItem(
                  floorId: floorId,
                  roomId: roomId,
                  itemTypeId: itemTypeId,
                  nameItemType: name,
                ),
              ),
            );
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 100,
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
                      'Name: $name \nID: $itemTypeId',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: Text('Update Item Type'),
              onPressed: () async {
                final docUser = FirebaseFirestore.instance
                    .collection('Floor')
                    .doc(floorId)
                    .collection('Rooms')
                    .doc(roomId)
                    .collection('ItemTypes')
                    .doc(itemTypeId);
                // Update user
                docUser.update({
                  'name':
                      (controllerName.text == '' ? name : controllerName.text),
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
            DisplayItems(
              floorId: floorId,
              roomId: roomId,
              itemTypeId: itemTypeId,
              itemTypeName: name,
            ),
          ],
        ),
      );
}
