import 'package:cloud_firestore/cloud_firestore.dart';
import 'globalsClasses.dart';
Stream<List<Building>> readBuilding() => FirebaseFirestore.instance
    .collection('Building')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Building.fromJson(doc.data())).toList());
