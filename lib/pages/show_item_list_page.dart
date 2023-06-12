import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/database/place_to_list.dart';

class ShowItemListPage extends StatefulWidget {  
  @override
  const ShowItemListPage({super.key, 
  required this.building,
  required this.floor,
  required this.room,
  });
  final String building;
  final String floor;
  final String room;
  
  State<ShowItemListPage> createState() => _ShowItemListPageState();
}

class _ShowItemListPageState extends State<ShowItemListPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }}
