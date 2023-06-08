import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'list_Rooms.dart';
import 'globalsClasses.dart';

class ListFloors extends StatefulWidget {
  final String buildingId;
  const ListFloors({Key? key, required this.buildingId}) : super(key: key);

  @override
  _ListFloorsState createState() => _ListFloorsState();
}

class _ListFloorsState extends State<ListFloors> {
  String? selectedFloorId;

  Stream<List<Floor>> readFloors() => FirebaseFirestore.instance
      .collection('Building')
      .doc(widget.buildingId)
      .collection('Floor')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Floor.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<Floor>>(
          stream: readFloors(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData) {
              final floors = snapshot.data;

              return Column(
                children: [
                  if (selectedFloorId == null)
                    Expanded(
                      child: ListView.builder(
                        itemCount: floors!.length,
                        itemBuilder: (context, index) {
                          final floor = floors[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedFloorId = floor.id;
                              });
                            },
                            child: Container(
                              margin:
                              const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Text(
                                  'Piętro ' +floor.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (selectedFloorId != null)
                    Expanded(
                      child: DisplayRooms(
                        floorId: selectedFloorId!, buildingId: widget.buildingId,
                      ),
                    ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ),
  );
}

