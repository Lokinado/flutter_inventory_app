import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/database/edit_Room.dart
import '../database/list_ItemTypes.dart';
import 'package:inventory_app/database/add_ItemType.dart';
=======
// import 'add_ItemTypeNew.dart';
// import 'edit_ItemTypeNew.dart';
// import 'list_ItemTypes.dart';
import 'list_ItemTypesNew.dart';
import 'list_Items.dart';
// import 'list_of_ItemTypes.dart';
// import 'add_ItemType.dart';
>>>>>>> DBCreatingUpdating:lib/edit_Room.dart

class EditRoom extends StatelessWidget {
  final String name;
  final String buildingId;
  final String roomId;
  final String floorId;

  EditRoom({
    Key? key,
    required this.name,
    required this.buildingId,
    required this.roomId,
    required this.floorId,
  }) : super(key: key);

  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit room: $name'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  settings: const RouteSettings(name: '/edit_room'),
                  builder: (context) => ListItemTypes(
                        buildingId: buildingId,
                        floorId: floorId,
                        roomId: roomId,
                        // name: name,
                        // itemTypeId: buildingId,
                        // floorId: floorId,
                        // roomId: roomId,
                      )
                  //  AddItemType(
                  //   buildingId: buildingId,
                  //   floorId: floorId,
                  //   roomId: roomId,
                  // ),
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
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Name: $name \nID: $roomId',
                      style: const TextStyle(fontSize: 20),
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
              child: const Text('Update'),
              onPressed: () async {
                final docUser = FirebaseFirestore.instance
                    .collection('Building')
                    .doc(buildingId)
                    .collection('Floor')
                    .doc(floorId)
                    .collection('Rooms')
<<<<<<< HEAD:lib/database/edit_Room.dart
                    .doc('$roomId');
                // Update user
                docUser.update({
=======
                    .doc(roomId);
                docRoom.update({
>>>>>>> DBCreatingUpdating:lib/edit_Room.dart
                  'name':
                      (controllerName.text == '' ? name : controllerName.text),
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
<<<<<<< HEAD:lib/database/edit_Room.dart
           
=======

            DisplayItems(
              buildingId: buildingId,
              floorId: floorId,
              roomId: roomId,
            )
            // DisplayItemsType(
            // buildingId: buildingId, floorId: floorId, roomId: roomId),
>>>>>>> DBCreatingUpdating:lib/edit_Room.dart
          ],
        ),
      );
}
