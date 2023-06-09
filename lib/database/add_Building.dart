import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/globalsClasses.dart';

class AddBuilding extends StatelessWidget {
  final controllerName = TextEditingController();

  AddBuilding({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add building'),
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
              child: const Text('Create building'),
              onPressed: () async {
                final building = Building(
                  name: controllerName.text,
                );

                createFloor(building);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

  Future createFloor(Building building) async {
    final docBuilding = FirebaseFirestore.instance.collection('Building').doc();
    building.id = docBuilding.id;

    final json = building.toJson();
    await docBuilding.set(json);
  }
}
