import 'package:flutter/material.dart';
import 'add_Building.dart';
import 'edit_ Building.dart';
import 'list_Floors.dart';
import 'readJSON.dart';
import 'globalsClasses.dart';

class ListBuildings extends StatefulWidget {
  @override
  _ListBuildingsState createState() => _ListBuildingsState();
}

class _ListBuildingsState extends State<ListBuildings> {
  String? selectedBuildingId;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(3),
            
            child: StreamBuilder<List<Building>>(
              stream: readBuilding(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData) {
                  final buildings = snapshot.data;

                  return Column(
                    children: [
                      if (selectedBuildingId == null)
                        Expanded(
                          child: ListView.builder(
                            itemCount: buildings!.length,
                            itemBuilder: (context, index) {
                              final building = buildings[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedBuildingId = building.id;
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      building.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (selectedBuildingId != null)
                        Expanded(
                          child: ListFloors(
                            buildingId: selectedBuildingId!,
                          ),
                        ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      );
}

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
