import 'package:flutter/material.dart';
import 'list_Floors.dart';
import 'add_Floor.dart';

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
                child: const Text('Add Floor'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddFloor()));
                },
              ),
              ElevatedButton(
                child: const Text('List Floors'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListFloors()));
                },
              ),
            ],
          ),
        ),
      );
}
