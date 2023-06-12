import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/database/report_generator.dart';

Future raportToDataBase(Report rapotObject) async {
  final docReport = FirebaseFirestore.instance
      .collection('ReportsData')
      .doc(rapotObject.report_number.toString());

  final json = rapotObject.toJson();
  await docReport.set(json);
}

