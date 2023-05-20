import 'package:flutter/material.dart';
import 'package:inventory_app/pages/adding/addhomebodypage.dart';
import 'package:inventory_app/components/topbodysection.dart';

class ScannerHomeBody extends StatelessWidget {
  const ScannerHomeBody({super.key,
    required this.title,
    required this.size,
    required this.location
  });

  final Size size;
  final String title;
  final Location location;

  @override
  Widget build(BuildContext context){
    return Wrap(
      children: <Widget>[
        TopBodySection(key: UniqueKey(),
          tekst: title,size: size, location: location,),
        CenterAddHomePage(key: UniqueKey(), size: size, location: location,)
      ],
    );
  }
}


