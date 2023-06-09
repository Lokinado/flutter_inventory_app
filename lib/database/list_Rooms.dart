import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:inventory_app/database/edit_Room.dart';
import 'package:inventory_app/database/list_Items.dart';
import 'listing_items.dart';

class DisplayRooms extends StatefulWidget {
  final String buildingId;
  final String floorId;

  const DisplayRooms(
      {Key? key, required this.buildingId, required this.floorId})
      : super(key: key);

  @override
  _ListRoomsState createState() => _ListRoomsState();
}

class _ListRoomsState extends State<DisplayRooms> {
  String? selectedRoomId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: StreamBuilder<List<Room>>(
        stream: DisplayRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData) {
            final rooms = snapshot.data!;

            return ListView(
              children: rooms
                  .map(
                    (room) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayItems(
                              buildingId: widget.buildingId,
                              floorId: widget.floorId,
                              roomId: room,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'Pomieszczenie ' + room,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
<<<<<<< HEAD:lib/database/list_Rooms.dart
=======
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
>>>>>>> DBCreatingUpdating:lib/list_Rooms.dart
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
<<<<<<< HEAD:lib/database/list_Rooms.dart
            return Center(child: Text('No rooms found'));
=======
            return const Center(child: CircularProgressIndicator());
>>>>>>> DBCreatingUpdating:lib/list_Rooms.dart
          }
        },
      ),
    
    );
  }
}
