import 'package:flutter/material.dart';
import 'list_Rooms.dart';
import 'globalsClasses.dart';
import 'listing_items.dart';

class ListFloors extends StatefulWidget {
  final String buildingId;

  const ListFloors({Key? key, required this.buildingId}) : super(key: key);

  @override
  _ListFloorsState createState() => _ListFloorsState();
}

class _ListFloorsState extends State<ListFloors> {
  String? selectedFloorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    
      body: Center(
        
        child: Container(
          color: Colors.white,
          child: FutureBuilder<List<String>>(
            future: pobierzPietra(widget.buildingId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Something went wrong: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final floors = snapshot.data!;

                return Column(
                  children: [
                    if (selectedFloorId == null)
                      Expanded(
                        child: ListView.builder(
                          itemCount: floors.length,
                          itemBuilder: (context, index) {
                            final floor = floors[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFloorId = floor;
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
                                    'Piętro $floor',
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
                    if (selectedFloorId != null)
                      Expanded(
                        child: DisplayRooms(
                          floorId: selectedFloorId!,
                          buildingId: widget.buildingId,
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
    );
  }
}
