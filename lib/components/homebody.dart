import 'package:flutter/material.dart';
import 'package:inventory_app/components/centerhomebody.dart';
import 'package:inventory_app/components/topbodysection.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
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


