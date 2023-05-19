import 'package:flutter/material.dart';
import 'package:inventory_app/components/homebody.dart';

class WyborMiejsca extends StatefulWidget {
  @override
  _WyborMiejscaState createState() => _WyborMiejscaState();
}

class _WyborMiejscaState extends State<WyborMiejsca> {

  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery .of(context) .size;
    return Scaffold(body: Body(title: "Pierwsza", size: rozmiar));
  }

}