import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:inventory_app/database/list_Floors.dart';
import 'listing_items.dart';

class ListBuildings extends StatefulWidget {
  @override
  _ListBuildingsState createState() => _ListBuildingsState();
}

class _ListBuildingsState extends State<ListBuildings> {
  String? selectedBuildingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          child: FutureBuilder<List<String>>(
            future: pobierzBudynki(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Something went wrong: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final buildings = snapshot.data!;

                return Column(
                  children: [
                    if (selectedBuildingId == null)
                      Expanded(
                        child: ListView.builder(
                          itemCount: buildings.length,
                          itemBuilder: (context, index) {
                            final building = buildings[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedBuildingId = building;
                                });
                              },
                              child: Container(
                                margin:const EdgeInsets.symmetric(vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Budynek $building',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
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
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            selectedBuildingId = null;
          });
        },
        child: Icon(Icons.home_filled),
        backgroundColor: zielonySGGW,
      ),
    );
  }
}
