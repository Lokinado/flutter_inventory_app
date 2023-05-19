import 'package:flutter/material.dart';
import 'package:inventory_app/components/homebody.dart';
import 'package:inventory_app/components/topbodysection.dart';

class FilePage extends StatefulWidget {
  @override
  _FilePageState createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery .of(context) .size;
    return Scaffold(body: Body(
        title: "Dokumenty", size: rozmiar, location: Location.right,));
  }
}
