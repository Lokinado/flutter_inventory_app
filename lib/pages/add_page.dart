import 'package:flutter/material.dart';
import 'package:inventory_app/components/homebody.dart';
import 'package:inventory_app/components/topbodysection.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery .of(context) .size;
    return Scaffold(body: Body(title: "Dodawanie", size: rozmiar, location: Location.left,));
  }
}
