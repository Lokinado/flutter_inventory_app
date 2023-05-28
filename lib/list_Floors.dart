import 'package:flutter/material.dart';
import 'add_Floor.dart';
import 'edit_Floor.dart';
import 'readJSON.dart';
import 'materials.dart';

class ListFloors extends StatelessWidget{

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('List floors'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddFloor()));
          },
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10.0),
            child: StreamBuilder<List<Floor>>(
              stream: readFloors(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData) {
                  final floors = snapshot.data;

                  return ListView(
                    children: floors!
                        .map((floor) => Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5,
                                  color: Colors.amber,
                                ),

                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                // border: Border.all(),
                              ),
                              child: buildFloor(floor, context),
                            ))
                        .toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      );

  Widget buildFloor(Floor floor, BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditFloor(
                name: floor.name,
                floorId: floor.id,
              ),
            ),
          ); // Navigator.push
        },
        child: ListTile(
          title: Text(floor.name),
        ),
      );
}
