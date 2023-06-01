import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/globalsClasses.dart';

class AddFloor extends StatelessWidget {
  final String buildingId;

  final controllerName = TextEditingController();

  AddFloor({
    Key? key,
    required this.buildingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add floor'),
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
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Create floor'),
              onPressed: () async {
                final floor = Floor(
                  name: controllerName.text,
                );

                createFloor(floor);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

  Future createFloor(Floor floor) async {
    final docFloor = FirebaseFirestore.instance
        .collection('Building')
        .doc(buildingId)
        .collection('Floor')
        .doc();

    floor.id = docFloor.id;
    final json = floor.toJson();
    await docFloor.set(json);
  }
}
