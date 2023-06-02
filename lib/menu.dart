import 'package:flutter/material.dart';
import 'add_Building.dart';
import 'list_Buildings.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Add Building'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddBuilding()));
                },
              ),
              ElevatedButton(
                child: const Text('List of buildings'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListBuildings()));
                },
              ),
            ],
          ),
        ),
      );
}
