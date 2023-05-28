import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'materials.dart';
import 'edit_ItemType.dart';

class DisplayItemsType extends StatelessWidget {
  final String floorId;
  final String roomId;

  const DisplayItemsType(
      {Key? key, required this.floorId, required this.roomId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: StreamBuilder<List<ItemType>>(
        stream: readItemTypes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            final itemTypes = snapshot.data;

            return ListView(
              children: itemTypes!
                  .map((itemType) => Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: buildItemType(itemType, context),
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

  Stream<List<ItemType>> readItemTypes() => FirebaseFirestore.instance
      .collection('Floor')
      .doc(floorId)
      .collection('Rooms')
      .doc(roomId)
      .collection('ItemTypes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ItemType.fromJson(doc.data())).toList());

  Widget buildItemType(ItemType itemType, BuildContext context) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditItemType(
                name: itemType.name,
                roomId: roomId,
                floorId: floorId,
                itemTypeId: itemType.id,
              ),
            ),
          );
        },
        child: ListTile(
          title: Text(itemType.name),
        ),
      );
}
