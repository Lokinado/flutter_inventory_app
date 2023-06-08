import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globalsClasses.dart';
import 'package:inventory_app/database/show_Item.dart';

class DisplayItems extends StatelessWidget {
  final String buildingId;
  final String floorId;
  final String roomId;
  final String roomName;

  const DisplayItems({
    Key? key,
    required this.buildingId,
    required this.floorId,
    required this.roomId,
    required this.roomName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        title: Text('Przedmioty z pomieszczenia ' + roomName,
         style: TextStyle(fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 0.1,
                      ),
          ],
       ),
         ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<Item>>(
          stream: readItems(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData) {
              final items = snapshot.data;

              return ListView(
                children: items!
                    .map((item) => Card(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Center(
                              child: Text(
                                '${item.name} \n  barcode: ${item.barcode}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 0.1,
                      ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowItem(
                                    name: item.name,
                                    roomId: roomId,
                                    floorId: floorId,
                                    itemId: item.id,
                                    comment: item.comment,
                                    barcode: item.barcode,
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
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

  Stream<List<Item>> readItems() => FirebaseFirestore.instance
      .collection('Building')
      .doc(buildingId)
      .collection('Floor')
      .doc(floorId)
      .collection('Rooms')
      .doc(roomId)
      .collection('Item')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());
}
