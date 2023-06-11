// import 'package:flutter/material.dart';
// import 'add_ItemTypeNew.dart';
// import 'edit_ItemTypeNew.dart';
// import 'globalsClasses.dart';
// // import 'package:inventory_app/edit_%20Building.dart';
// import 'readJSON.dart';

// class ListItemTypes extends StatelessWidget {
//   final String buildingId;
//   final String floorId;
//   final String roomId;

//   final controller = TextEditingController();

//   ListItemTypes(
//       {super.key,
//       required this.buildingId,
//       required this.floorId,
//       required this.roomId});

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('List ItemTypes'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             // getAllCollectionNames2();
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => AddItemType(
//                       buildingId: buildingId,
//                       floorId: floorId,
//                       roomId: roomId,
//                     )));
//           },
//         ),
//         body: Center(
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             margin: const EdgeInsets.all(10.0),
//             child: StreamBuilder<List<ItemType>>(
//               stream: readItemTypes(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return const Text('Something went wrong');
//                 } else if (snapshot.hasData) {
//                   final itemTypes = snapshot.data;

//                   return ListView(
//                     children: itemTypes!
//                         .map((itemType) => Container(
//                               margin: const EdgeInsets.all(5.0),
//                               padding: const EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   width: 5,
//                                   color: Colors.amber,
//                                 ),

//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(50)),
//                                 // border: Border.all(),
//                               ),
//                               child: buildBuilding(itemType, context),
//                             ))
//                         .toList(),
//                   );
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//         ),
//       );

//   Widget buildBuilding(ItemType itemType, BuildContext context) =>
//       GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EditItemType(
//                 buildingId: buildingId,
//                 floorId: floorId,
//                 roomId: roomId,
//                 name: itemType.name,
//                 itemTypeId: itemType.id,
//               ),
//             ),
//           ); // Navigator.push
//         },
//         child: ListTile(
//           title: Text(itemType.name),
//         ),
//       );
// }
