import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globalsClasses.dart';
import 'edit_Room.dart';
import 'list_ItemTypes.dart';

class DisplayRooms extends StatefulWidget {
  final String buildingId;
  final String floorId;

  const DisplayRooms({Key? key, required this.buildingId, required this.floorId})
      : super(key: key);

  @override
  _ListRoomsState createState() => _ListRoomsState();
}

class _ListRoomsState extends State<DisplayRooms> {
  String? selectedRoomId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Room>>(
      stream: readRooms(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData) {
          final rooms = snapshot.data;

          return ListView(
            children: rooms!
                .map(
                  (room) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayItemsType(
                        buildingId:widget.buildingId,
                        floorId: widget.floorId,
                        roomId: room.id, roomName: room.name,

                      ),
                    ),
                  );
                },
                child: Container(

                  
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      room.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }


  Stream<List<Room>> readRooms() => FirebaseFirestore.instance
      .collection('Building')
      .doc(widget.buildingId)
      .collection('Floor')
      .doc(widget.floorId)
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
                buildingId: widget.buildingId,
                name: room.name,
                roomId: room.id,
                floorId: widget.floorId,
              ),
            ),
          );
        },
        child: ListTile(
          title: Text(room.name),
        ),
      );
}
