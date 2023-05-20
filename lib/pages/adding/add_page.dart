import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/pages/adding/addhomebody.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery .of(context) .size;
    return Scaffold(body: ScannerHomeBody(title: "Dodawanie", size: rozmiar, location: Location.left,));
  }
}
