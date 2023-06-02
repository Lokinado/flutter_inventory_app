import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_Room.dart';
import 'list_Rooms.dart';

class EditFloor extends StatelessWidget {
  final String name;
  final String buildingId;
  final String floorId;

  EditFloor({
    Key? key,
    required this.name,
    required this.buildingId,
    required this.floorId,
  }) : super(key: key);

  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit floor: $name'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddRoom(
                  buildingId: buildingId,
                  floorId: floorId,
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
                height: 80,
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
                      'Name: $name \nID: $floorId',
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
            const SizedBox(height: 24),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () async {
                final docUser = FirebaseFirestore.instance
                    .collection('Building')
                    .doc(buildingId)
                    .collection('Floor')
                    .doc('$floorId');
                docUser.update({
                  'name':
                      (controllerName.text == '' ? name : controllerName.text),
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
            DisplayRooms(buildingId: buildingId, floorId: floorId),
          ],
        ),
      );
}
