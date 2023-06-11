
import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/pages/list_page.dart';
import 'package:inventory_app/database/place_to_list.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

/*
class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery .of(context) .size;
    return Scaffold(body: ScannerHomeBody(title: "Dodawanie", size: rozmiar, location: Location.left,));
  }
}
*/

class _AddPageState extends State<AddPage>
    with AutomaticKeepAliveClientMixin<AddPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ListPage();
  }

}
