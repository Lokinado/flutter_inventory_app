import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  static var dataHere=<String>['PlaceHolder1', 'PlaceHolder2'];

  @override
  Widget build(BuildContext context){
      return Scaffold(
        body: SafeArea(
          child: Center(
          child: Column(
            children:[
              for(var data in dataHere)
              ListTile(
                title: Text(data),
              ),
          ]
          ),
          ),
        ),
      );
  }
}