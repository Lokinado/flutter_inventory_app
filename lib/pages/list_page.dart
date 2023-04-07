import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  static var dataHere=<String>['PlaceHolder1', 'PlaceHolder2'];

  @override
  Widget build(BuildContext context){
      return Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: dataHere.length,
            itemBuilder:(context, index){
              return Text('Test');
            },
          ),
          ),
          );

  }
}