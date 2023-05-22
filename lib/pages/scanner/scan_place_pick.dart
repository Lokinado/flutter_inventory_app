import 'package:flutter/material.dart';
import 'package:inventory_app/pages/scanner/scannerhomebody.dart';
import 'package:inventory_app/components/topbodysection.dart';

class WyborMiejsca extends StatefulWidget {
  @override
  _WyborMiejscaState createState() => _WyborMiejscaState();
}

class _WyborMiejscaState extends State<WyborMiejsca> {

  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery .of(context) .size;
    return Scaffold(body: ScannerHomeBody(
        title: "Skanownanie", size: rozmiar, location: Location.center));
  }

}