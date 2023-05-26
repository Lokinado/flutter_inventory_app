import 'package:cloud_firestore/cloud_firestore.dart';
import 'materials.dart';

Stream<List<Floor>> readFloors() =>
    FirebaseFirestore.instance.collection('Floor').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Floor.fromJson(doc.data())).toList());
