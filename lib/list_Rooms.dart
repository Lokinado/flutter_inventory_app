import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testdb/materials.dart';
import 'edit_Room.dart';
// import '../Rooms/add_Room.dart';

class DisplayRooms extends StatelessWidget {
  final String floorId;

  const DisplayRooms({Key? key, required this.floorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: StreamBuilder<List<Room>>(
        stream: readRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            final rooms = snapshot.data;

            return ListView(
              children: rooms!
                  .map((room) => Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: buildRoom(room, context),
                      ))
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<Room>> readRooms() => FirebaseFirestore.instance
      .collection('Floor')
      .doc(floorId)
      .collection('Rooms')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Room.fromJson(doc.data())).toList());

  Widget buildRoom(Room room, BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditRoom(
                name: room.name,
                roomId: room.id,
                floorId: floorId,
              ),
            ),
          );
        },
        child: ListTile(
          title: Text(room.name),
        ),
      );
}
