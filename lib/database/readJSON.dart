import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/database/globalsClasses.dart';

Stream<List<Building>> readBuilding() => FirebaseFirestore.instance
    .collection('Building')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Building.fromJson(doc.data())).toList());

Stream<List<ItemType>> readItemTypes() => FirebaseFirestore.instance
    .collection('ItemTypes')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => ItemType.fromJson(doc.data())).toList());
