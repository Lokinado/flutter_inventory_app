import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:inventory_app/database/edit_ItemType.dart';
import 'package:inventory_app/database/list_Items.dart';

class DisplayItemsType extends StatelessWidget {
  final String buildingId;
  final String floorId;
  final String roomId;
  final String roomName;

  const DisplayItemsType({
    Key? key,
    required this.buildingId,
    required this.floorId,
    required this.roomId,
    required this.roomName,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        title: Text(roomName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<ItemType>>(
          stream: readItemTypes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData) {
              final itemTypes = snapshot.data;

              return ListView(
                children: itemTypes!
                    .map(
                      (itemType) => Card(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          itemType.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayItems (
                              roomId: roomId,
                              floorId: floorId,
                              itemTypeId: itemType.id, itemTypeName: itemType.name, buildingId: buildingId,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
                    .toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }


  Stream<List<ItemType>> readItemTypes() => FirebaseFirestore.instance
      .collection('Building')
      .doc(buildingId)
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
                buildingId: buildingId,
                floorId: floorId,
                roomId: roomId,
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
