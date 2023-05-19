import 'package:flutter/material.dart';
import 'package:inventory_app/components/centerhomebody.dart';
import 'package:inventory_app/components/topbodysection.dart';

class Body extends StatelessWidget {
  const Body({super.key,
    required this.title,
    required this.size,
    required this.location
  });

  final Size size;
  final String title;
  final Location location;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TopBodySection(key: UniqueKey(),
            tekst: title,size: size, location: location,),
          CenterBodySection(key: UniqueKey(), size: size, location: location,)
        ],
      ),
    );
  }
}


