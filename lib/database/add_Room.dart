import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globalsClasses.dart';

class AddRoom extends StatelessWidget {
  final String buildingId;
  final String floorId;

  AddRoom({
    Key? key,
    required this.buildingId,
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
        .collection('Building')
        .doc(buildingId)
        .collection('Floor')
        .doc(floorId)
        .collection('Rooms')
        .doc(room.name);

    final json = room.toJson();
    await docRoom.set(json);
  }
}
