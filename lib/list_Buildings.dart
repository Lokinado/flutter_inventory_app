import 'package:flutter/material.dart';
import 'package:inventory_app/edit_%20Building.dart';
import 'add_Building.dart';
// import 'add_Floor.dart';
// import 'edit_Floor.dart';
import 'readJSON.dart';
import 'globalsClasses.dart';

class ListBuildings extends StatelessWidget {
  final controller = TextEditingController();

  ListBuildings({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('List Building'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddBuilding()));
          },
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10.0),
            child: StreamBuilder<List<Building>>(
              stream: readBuilding(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.hasData) {
                  final buildings = snapshot.data;

                  return ListView(
                    children: buildings!
                        .map((building) => Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5,
                                  color: Colors.amber,
                                ),

                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                // border: Border.all(),
                              ),
                              child: buildBuilding(building, context),
                            ))
                        .toList(),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      );

  Widget buildBuilding(Building building, BuildContext context) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditBuilding(
                name: building.name,
                buildingId: building.id,
              ),
            ),
          ); // Navigator.push
        },
        child: ListTile(
          title: Text(building.name),
        ),
      );
}
