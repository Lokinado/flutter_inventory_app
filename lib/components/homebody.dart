import 'package:flutter/material.dart';
import 'package:inventory_app/components/centerhomebody.dart';
import 'package:inventory_app/components/topbodysection.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TopBodySection(key: UniqueKey(), tekst: "Wybór miejsca",size: size),
          CenterBodySection(key: UniqueKey())
        ],
      ),
    );
  }
}


