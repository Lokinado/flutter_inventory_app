import 'package:flutter/material.dart';
import 'package:inventory_app/prefab/homebody.dart';
import 'package:inventory_app/components/topbodysection.dart';

class Room {
  final int building;
  final int level;
  final int roomNumber;

  Room(this.building, this.level, this.roomNumber);
}

class ListPage extends StatefulWidget {

  ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children:[
        TopBodySection(key: UniqueKey(),
            tekst: 'Pomieszczenia',size: MediaQuery.of(context).size, location: Location.left),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255 ,87, 178, 122),
              child: IconButton(
                onPressed: () {print("dodaje obiekt!");},
                icon: const Icon(Icons.add, color: Colors.white,),
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
        child: ListView(
          children: [
            for (int building in uniqueBuildings)
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.black, // here for close state
                    colorScheme: const ColorScheme.light(
                      primary: Colors.black,
                    ), // here for open state in replacement of deprecated accentColor
                    dividerColor: Colors.transparent, // if you want to remove the border
                  ),
                  child: ExpansionTile(
                    title: Text('Budynek $building'),
                    textColor: Colors.black,
                    collapsedTextColor: Colors.black,
                    shape: const Border(),
                    children: [
                      for (int level in uniqueFloors)
                        if (rooms
                            .where((room) =>
                        room.building == building && room.level == level)
                            .isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(left: 12.0),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.black, // here for close state
                                colorScheme: const ColorScheme.light(
                                  primary: Colors.black,
                                ), // here for open state in replacement of deprecated accentColor
                                dividerColor: Colors.transparent, // if you want to remove the border
                              ),
                              child: ExpansionTile(
                                title: Text('Piętro $level'),
                                textColor: Colors.black,
                                collapsedTextColor: Colors.black,
                                children: [
                                  Column(
                                    children: _buildRoomTiles(building, level, mediaWidth),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),

          ],
        ),
        ),
          GestureDetector(
            onTap: () => print("tu przekierowanie"),
              child: Container(

                width: mediaWidth*0.8,
                height: 70.0,
                margin: const EdgeInsets.all(30.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255,148,175,159),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Dodaj i Wygeneruj kody",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildRoomTiles(int building, int floor, mediaWidth) {
    List<Widget> roomTiles = [];

    for (Room room in rooms) {
      if (room.building == building && room.level == floor) {
        roomTiles.add(
          Container(
            height: 50.0,
            width: mediaWidth*0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: const Color.fromARGB(217, 217, 217, 217)),
            margin: const EdgeInsets.only(left: 5.0, bottom: 5.0),
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

