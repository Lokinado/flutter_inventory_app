import 'package:flutter/material.dart';

class Room {
  final int building;
  final int level;
  final int roomNumber;

  Room(this.building, this.level, this.roomNumber);
}

class ListPage extends StatelessWidget {
  final List<Room> rooms = [
    Room(1, 1, 101),
    Room(1, 1, 102),
    Room(1, 2, 201),
    Room(2, 1, 101),
    Room(2, 2, 201),
    Room(2, 2, 202),
    Room(3, 2, 17),
    Room(3, 2, 18),
  ];

  final List<int> uniqueBuildings = [];
  final List<int> uniqueFloors = [];

  ListPage({super.key}) {
    _getUniqueBuildingsAndFloors();
  }

  void _getUniqueBuildingsAndFloors() {
    for (Room room in rooms) {
      if (!uniqueBuildings.contains(room.building)) {
        uniqueBuildings.add(room.building);
      }
      if (!uniqueFloors.contains(room.level)) {
        uniqueFloors.add(room.level);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (int building in uniqueBuildings)
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: ExpansionTile(
                title: Text('Budynek $building'),
                children: [
                  for (int level in uniqueFloors)
                    if (rooms
                        .where((room) =>
                    room.building == building && room.level == level)
                        .isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 12.0),
                        child: ExpansionTile(
                          title: Text('Piętro $level'),
                          children: [
                            Column(
                              children: _buildRoomTiles(building, level),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildRoomTiles(int building, int floor) {
    List<Widget> roomTiles = [];

    for (Room room in rooms) {
      if (room.building == building && room.level == floor) {
        roomTiles.add(
          Container(
            height: 50.0,
            width: 300.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey),
            margin: const EdgeInsets.only(left: 20.0, bottom: 5.0),
            child: ListTile(
              title: Text('Sala ${room.roomNumber}'),
              onTap: ()=>print("tu mam przejśc gdzieś!"), //TODO: Przejście do innej strony
            ),
          ),
        );
      }
    }

    return roomTiles;
  }
}


