import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_Floor.dart';
import 'globalsClasses.dart';

class DisplayFloors extends StatelessWidget {
  final String buildingId;

  const DisplayFloors({Key? key, required this.buildingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: StreamBuilder<List<Floor>>(
        stream: readFloors(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData) {
            final floors = snapshot.data;

            return ListView(
              children: floors!
                  .map((floor) => Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.amber,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        child: buildFloor(floor, context),
                      ))
                  .toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<Floor>> readFloors() => FirebaseFirestore.instance
      .collection('Building')
      .doc(buildingId)
      .collection('Floor')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Floor.fromJson(doc.data())).toList());

  Widget buildFloor(Floor floor, BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditFloor(
                name: floor.name,
                buildingId: buildingId,
                floorId: floor.id,
              ),
            ),
          ); // Navigator.push
        },
        child: ListTile(
          title: Text(floor.name),
        ),
      );
}
