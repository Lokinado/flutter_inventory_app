import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/pages/documents/filehomebody.dart';

class FilePage extends StatefulWidget {
  @override
  _FilePageState createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery .of(context) .size;
    return Scaffold(body: FileHomePage(
        title: "Dokumenty", size: rozmiar, location: Location.right,));
  }
}
