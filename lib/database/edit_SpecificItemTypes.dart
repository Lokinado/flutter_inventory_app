import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/database/add_Item.dart';

class EditSpecificItemType extends StatelessWidget {
  final String name;
  final String itemTypeId;
  final String specItemId;
  final double price;

  final String buildingId;
  final String floorId;
  final String roomId;

  final String nameItemType;
  EditSpecificItemType({
    Key? key,
    required this.name,
    required this.itemTypeId,
    required this.specItemId,
    required this.price,
    required this.buildingId,
    required this.floorId,
    required this.roomId,
    required this.nameItemType,
  }) : super(key: key);

  final controllerName = TextEditingController();
  final controllerPrice = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit item specific type: $name'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // print(
            //     'buildingId: $buildingId\nfloorId: $floorId\nroomId: $roomId\nitemTypeId: $itemTypeId\nspecItemId: $specItemId\nnameItemType: $nameItemType\nnameSpecItemType: $name\n');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddItem(
                  buildingId: buildingId,
                  floorId: floorId,
                  roomId: roomId,
                  itemTypeId: itemTypeId,
                  specItemId: specItemId,
                  nameItemType: nameItemType,
                  nameSpecItemType: name,
                ),
              ),
            );
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 300,
                width: 240,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Name: $name \nID: $itemTypeId\nPrice: $price\nbuilding: $buildingId\nfloorId: $floorId\nroomId: $roomId\nnameItemType: $nameItemType\nnameSpecItemType: $name\n ',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              maxLength: 20,
              controller: controllerName,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            TextField(
              maxLength: 20,
              keyboardType: TextInputType.number,
              controller: controllerPrice,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                hintText: 'Price',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: const Text('Update Item Type'),
              onPressed: () async {
                final docItemType = FirebaseFirestore.instance
                    .collection('ItemTypes')
                    .doc(itemTypeId)
                    .collection('Branch')
                    .doc(specItemId);

                docItemType.update({
                  'name':
                      (controllerName.text == '' ? name : controllerName.text),
                  'price': (controllerPrice.text == ''
                      ? price
                      : double.parse(controllerPrice.text)),
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
}
