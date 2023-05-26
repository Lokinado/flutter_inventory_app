import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'materials.dart';

class AddRoom extends StatelessWidget {
  final String floorId;

  AddRoom({
    Key? key,
    required this.floorId,
  }) : super(key: key);

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add room'),
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
              child: const Text('Create room'),
              onPressed: () async {
                final room = Room(
                  name: controllerName.text,
                  // age: int.tryParse(controllerAge.text) ?? 0,
                  // birthday: Timestamp.now(),
                );

                createRoom(room);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

  Future createRoom(Room room) async {
    final docRoom = FirebaseFirestore.instance
        .collection('Floor')
        .doc(floorId)
        .collection('Rooms')
        .doc();
    room.id = docRoom.id;

    final json = room.toJson();
    await docRoom.set(json);
  }
}