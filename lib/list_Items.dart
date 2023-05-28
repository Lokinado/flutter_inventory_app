import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'materials.dart';
import 'edit_Item.dart';

class DisplayItems extends StatelessWidget {
  final String floorId;
  final String roomId;
  final String itemTypeId;
  final String itemTypeName;

  const DisplayItems({
    Key? key,
    required this.floorId,
    required this.roomId,
    required this.itemTypeId,
    required this.itemTypeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: StreamBuilder<List<Item>>(
        stream: readItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            final items = snapshot.data;

            return ListView(
              children: items!
                  .map((items) => Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: buildItem(items, context),
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

  Stream<List<Item>> readItems() => FirebaseFirestore.instance
      .collection('Floor')
      .doc(floorId)
      .collection('Rooms')
      .doc(roomId)
      .collection('ItemTypes')
      .doc(itemTypeId)
      .collection('Item')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  Widget buildItem(Item item, BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditItem(
                name: item.name,
                roomId: roomId,
                floorId: floorId,
                itemTypeId: itemTypeId,
                itemTypeName: itemTypeName,
                itemId: item.id,
                comment: item.comment,

                barcode: item.barcode, //new
              ),
            ),
          );
        },
        child: ListTile(
          title: Text(item.name),
        ),
      );
}
