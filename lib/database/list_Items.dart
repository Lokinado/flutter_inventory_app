import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globalsClasses.dart';
import 'package:inventory_app/database/show_Item.dart';
import 'listing_items.dart';

class DisplayItems extends StatelessWidget {
  final String buildingId;
  final String floorId;
  final String roomId;

  const DisplayItems({
    Key? key,
    required this.buildingId,
    required this.floorId,
    required this.roomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
        title: Text(
          'Przedmioty z pomieszczenia $roomId',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.grey,
                blurRadius: 0.1,
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<List<String>>>(
          future: pobieraniePrzedmiotow(buildingId, floorId, roomId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              final items = snapshot.data!;

              return ListView(
                children: items
                    .map(
                      (item) => Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          title: Text(
                            '${BetterText(item[2])}\nbarcode: ${item[0]}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.grey,
                                  blurRadius: 0.1,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowItem(
                                  name: item[0],
                                  buildingId: buildingId,
                                  roomId: roomId,
                                  floorId: floorId,
                                  itemtype: item[2].toString(),
                                  comment: item[1],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Usuń przedmiot'),
                content: const Text(
                    'Czy na pewno chcesz usunąć pomieszczenie i jej przedmioty?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Anuluj'),
                  ),
                  TextButton(
                    onPressed: () {
                      //funkcja usuwająca pomieszczenie
                      RemoveRoom(buildingId, floorId, roomId);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Usuń'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.remove),
      ),
    );
  }
}

///function to remove room
void RemoveRoom(buildingId, floorId, roomId) async {
  final docRoom = FirebaseFirestore.instance
      .collection('Building')
      .doc(buildingId)
      .collection('Floors')
      .doc(floorId)
      .collection('Rooms')
      .doc(roomId);

  print(floorId);
  print(roomId);
  docRoom.delete();
}

String BetterText(String input) {
  List<String> NoSlashes = input.split('/');
  int textlen = NoSlashes.length;
  String rettext = "";
  for (int i = 2; i < textlen; i++) {
    rettext = rettext + NoSlashes[i] + " ";
  }
  return rettext;
}
