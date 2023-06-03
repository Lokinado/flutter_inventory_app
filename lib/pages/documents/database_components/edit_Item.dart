import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  final String name;
  final String roomId;
  final String floorId;
  final String itemTypeId;
  final String itemTypeName;
  final String itemId;
  final String comment;

  final String barcode;

  EditItem({
    Key? key,
    required this.name,
    required this.roomId,
    required this.floorId,
    required this.itemTypeId,
    required this.itemTypeName,
    required this.itemId,
    required this.comment,
    required this.barcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
      title: Text('Szczegóły  $name'),
    ),
    body: ListView(
      
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: SizedBox(
            height: 100,
            width: 240,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child:  Padding(
                padding: EdgeInsets.all(5),

                child: Text(

                  'Nazwa: $name \nBarcode: $barcode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.normal,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
