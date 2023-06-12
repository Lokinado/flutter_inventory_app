/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'edit_Floor.dart';
import 'edit_SpecificItemTypes.dart';
import 'globalsClasses.dart';

class DisplaySpecificItemType extends StatelessWidget {
  final String itemTypeId;

  final String buildingId;
  final String floorId;
  final String roomId;

  final String nameItemType;
  const DisplaySpecificItemType(
      {Key? key,
      required this.itemTypeId,
      required this.buildingId,
      required this.floorId,
      required this.roomId,
      required this.nameItemType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: StreamBuilder<List<SpecificItemType>>(
        stream: readSpecificItemType(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            final specItems = snapshot.data;

            return ListView(
              children: specItems!
                  .map((specItems) => Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: buildSpecItem(specItems, context),
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

  Stream<List<SpecificItemType>> readSpecificItemType() =>
      FirebaseFirestore.instance
          .collection('ItemTypes')
          .doc(itemTypeId)
          .collection('Branch')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => SpecificItemType.fromJson(doc.data()))
              .toList());

  Widget buildSpecItem(SpecificItemType specItem, BuildContext context) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditSpecificItemType(
                name: specItem.name,
                itemTypeId: itemTypeId,
                specItemId: specItem.id,
                price: specItem.price,

                buildingId: buildingId,
                floorId: floorId,
                roomId: roomId,
                nameItemType: nameItemType,
                // dateOfPurchase: specItem.dateOfPurchase,
              ),
            ),
          ); // Navigator.push
        },
        child: ListTile(
          title: Text(specItem.name),
        ),
      );
}
 */