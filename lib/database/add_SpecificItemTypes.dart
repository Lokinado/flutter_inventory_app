// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'globalsClasses.dart';

// class AddSpecificItemType extends StatelessWidget {
//   final String itemTypeId;

//   AddSpecificItemType({
//     Key? key,
//     required this.itemTypeId,
//   }) : super(key: key);

//   final controllerName = TextEditingController();
//   final controllerPrice = TextEditingController();

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Add specific item type'),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.all(16),
//           children: <Widget>[
//             TextField(
//               maxLength: 20,
//               controller: controllerName,
//               decoration: const InputDecoration(
//                 counterText: '',
//                 border: OutlineInputBorder(),
//                 hintText: 'Name',
//               ),
//             ),
//             TextField(
//               keyboardType: TextInputType.number,
//               maxLength: 20,
//               controller: controllerPrice,
//               decoration: const InputDecoration(
//                 counterText: '',
//                 border: OutlineInputBorder(),
//                 hintText: 'Price',
//               ),
//             ),
//             const SizedBox(height: 24),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               child: const Text('Create specific item type'),
//               onPressed: () async {
//                 final specItemType = SpecificItemType(
//                   name: controllerName.text,
//                   price: double.parse(controllerPrice.text),
//                   // dateOfPurchase: DateTime.now(),
//                 );

//                 createRoom(specItemType);
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         ),
//       );

//   Future createRoom(SpecificItemType specItem) async {
//     final docSpecItem = FirebaseFirestore.instance
//         .collection('ItemTypes')
//         .doc(itemTypeId)
//         .collection('Branch')
//         .doc();
//     specItem.id = docSpecItem.id;

//     final json = specItem.toJson();
//     await docSpecItem.set(json);
//   }
// }
