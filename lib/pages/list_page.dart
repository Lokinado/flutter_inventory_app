import 'package:flutter/material.dart';

class Room {
  final int building;
  final int floor;
  final int roomNumber;

  Room(this.building, this.floor, this.roomNumber);
}

class ExpandableListApp extends StatelessWidget {
  final List<Room> rooms = [
    Room(1, 1, 101),
    Room(1, 1, 102),
    Room(1, 2, 201),
    Room(2, 1, 101),
    Room(2, 2, 201),
    Room(2, 2, 202),
  ];

  final List<int> uniqueBuildings = [];
  final List<int> uniqueFloors = [];

  ExpandableListApp() {
    _getUniqueBuildingsAndFloors();
  }

  void _getUniqueBuildingsAndFloors() {
    for (Room room in rooms) {
      if (!uniqueBuildings.contains(room.building)) {
        uniqueBuildings.add(room.building);
      }
      if (!uniqueFloors.contains(room.floor)) {
        uniqueFloors.add(room.floor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expandable List'),
      ),
      body: ListView(
        children: [
          for (int building in uniqueBuildings)
            ExpansionTile(
              title: Text('Building: $building'),
              children: [
                for (int floor in uniqueFloors)
                  if (rooms
                      .where((room) =>
                  room.building == building && room.floor == floor)
                      .isNotEmpty)
                    ExpansionTile(
                      title: Text('Floor: $floor'),
                      children: [
                        Column(
                          children: _buildRoomTiles(building, floor),
                        ),
                      ],
                    ),
              ],
            ),
        ],
      ),
    );
  }

  List<Widget> _buildRoomTiles(int building, int floor) {
    List<Widget> roomTiles = [];

    for (Room room in rooms) {
      if (room.building == building && room.floor == floor) {
        roomTiles.add(
          ListTile(
            title: Text('Room: ${room.roomNumber}'),
          ),
        );
      }
    }

    return roomTiles;
  }
}


