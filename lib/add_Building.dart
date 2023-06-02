import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globalsClasses.dart';

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
              maxLength: 20,
              controller: controllerName,
              decoration: const InputDecoration(
                counterText: '',
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
