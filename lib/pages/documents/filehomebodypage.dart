import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/pages/documents/details_arguments.dart';
import 'package:inventory_app/pages/documents/kody.dart';
import 'package:inventory_app/pages/documents/raporty.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/rounded_rectangle.dart';

class CenterFileHomePage extends StatefulWidget {
  CenterFileHomePage({Key? key, required this.size, required this.location})
      : super(key: key);

  final Size size;
  final Location location;

  @override
  State<CenterFileHomePage> createState() => _CenterFileHomePageState();
}

class _CenterFileHomePageState extends State<CenterFileHomePage>
    with AutomaticKeepAliveClientMixin<CenterFileHomePage> {
  String _selectedList = '';

  @override
  bool get wantKeepAlive => true;

  void _showList(String listName) {
    setState(() {
      _selectedList = listName;
    });
  }

  double roundness = 75;

  @override
  Widget build(BuildContext context) {
    var elemWidth = widget.size.width * 0.9;
    return Container(
      height: double.infinity,
      color: const Color.fromRGBO(0, 50, 39, 1),
      child: Container(
        width: widget.size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
                widget.location == Location.right? roundness : 0),
            topLeft: Radius.circular(
                widget.location == Location.left? roundness : 0),
          ),
        ),
      ),
    );
  }
}
