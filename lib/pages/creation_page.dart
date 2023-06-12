import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:inventory_app/components/user_input_dialog.dart';
import 'package:inventory_app/components/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/database/globalsClasses.dart';
import 'package:inventory_app/pages/logged_page.dart';


class CreationPage extends StatefulWidget {
  CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> with AutomaticKeepAliveClientMixin {
  
  bool get wantKeepAlive => true;

  List<String> listaBudynkow = [];
  List<String> listaPieter = [];
  List<String> listaPomieszczen = [];

  bool exists = false;

  String budynek = "";

  String pietro = "";

  String pomieszczenie = "";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mediasize = MediaQuery.of(context).size;
    double numberBoxSize = 60;
    double szerokoscPrzycisku = mediasize.width - 120;
    inicjalizujBudynki();
    return Scaffold(
      appBar: buildAppBar(context),
        body: 
        Column(
      children: [
        
        TopBodySection(key: UniqueKey(), size: mediasize, tekst: "Dodawanie", location: Location.center,),
        SizedBox(
          height: mediasize.height * 0.2,
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(children: [
                Container(
                  alignment: Alignment.center,
                  width: numberBoxSize,
                  height: numberBoxSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(roundness),
                      color: zielonySGGW),
                  child: Text(
                    budynek,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),

                /// Przycisk wyboru budynku
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  width: szerokoscPrzycisku,
                  height: 60.0,
                  child: ElevatedButton(
                    style: leftTextActive,
                    onPressed: () async {
                      String? wyborBudynku = await showUserInputDialog(
                        context: context,
                        label: "Budynek",
                        items: listaBudynkow,
                      );
                      if (wyborBudynku != null) {
                        setState(() {
                          // wybrano wartość inną niż wpisana => reset
                          if (budynek != wyborBudynku) {
                            budynek = wyborBudynku;
                            pietro = "";
                            pomieszczenie = "";
                          }
                        });
                        listaPieter = await pobierzPietra(budynek);
                      }
                    },
                    child: const Text(
                      "Budynek",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                //przycisk dodawania budynku
                //addEntityButton(context, EntityType.building, budynek, pietro, pomieszczenie),
              ]),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Row(
                children: [
                  /// Zielony kwadracik z numerem pietra
                  Container(
                    alignment: Alignment.center,
                    width: numberBoxSize,
                    height: numberBoxSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(roundness),
                        color: budynek != "" ? zielonySGGW : zielonySlabaSGGW),
                    child: Text(
                      pietro,
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),

                  /// Przycisk wyboru pietra
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    width: szerokoscPrzycisku,
                    height: 60.0,
                    child: ElevatedButton(
                      style: budynek != "" ? leftTextActive : leftTextNotActive,
                      onPressed: () async {
                        if (budynek != "") {
                          String? wyborPietra = await showUserInputDialog(
                            context: context,
                            label: "Piętro",
                            items: listaPieter,
                          );
                          if (wyborPietra != null) {
                            setState(() {
                              // wybrano wartość inną niż wpisana => reset
                              if (pietro != wyborPietra) {
                                pietro = wyborPietra;
                                pomieszczenie = "";
                              }
                            });
                            listaPomieszczen =
                                await pobierzPomieszczenia(budynek, pietro);
                          }
                        }
                      },
                      child: const Text(
                        "Piętro",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Wybór sali
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Row(
                children: [
                  /// Zielony kwadracik z numerem pomieszczenie
                  Container(
                    alignment: Alignment.center,
                    width: numberBoxSize,
                    height: numberBoxSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(roundness),
                        color: pietro != "" ? zielonySGGW : zielonySlabaSGGW),
                    child: Text(
                      pomieszczenie,
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),

                  /// Przycisk wyboru pomieszczenia
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    width: szerokoscPrzycisku,
                    height: 60.0,
                    child: ElevatedButton(
                      style: pietro != "" && budynek != ""
                          ? leftTextActive
                          : leftTextNotActive,
                      onPressed: () async {
                        if (pietro != "") {
                          String? wyborPomieszczenia = await showUserInputDialog(
                            context: context,
                            label: "Pomieszczenie",
                            items: listaPomieszczen
                          );
                          if (wyborPomieszczenia != null) {
                            setState(() {
                              if (pomieszczenie != wyborPomieszczenia) {
                                pomieszczenie = wyborPomieszczenia;
                              }
                            });
                          } 
                        }
                      },
                      child: const Text(
                        "Pomieszczenie",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if(pomieszczenie!="" && pietro!="" && budynek !="")//TODO: Przypadek kiedy nie ma piętra a jest budynek etc.
                {
                  if(listaPomieszczen.contains(pomieszczenie))
                  {
                    setState(() {
                      exists=true;
                    });
                  }
                  else
                  {
                    createRoom(budynek, pietro, pomieszczenie);
                    //Navigator.pop(context);
                    setState(() {
                      budynek="";
                      pietro="";
                      pomieszczenie="";
                    });
                  }
                }
                else if(pomieszczenie=="" && pietro!="" && budynek!="")
                {
                  if(listaPieter.contains(pietro))
                  {
                    setState(() {
                      exists=true;
                    });
                  }
                  else
                  {
                    createFloor(budynek, pietro);
                    //Navigator.pop(context);
                    setState(() {
                      budynek="";
                      pietro="";
                    });
                  }
                }
                else if(pomieszczenie=="" && pietro=="" && budynek!="")
                {
                  if(listaBudynkow.contains(budynek))
                  {
                    setState(() {
                      exists=true;
                    });
                  }
                  else
                  {
                    createBuilding(budynek);
                    //Navigator.pop(context);
                    setState(() {
                      budynek="";
                    });
                  }
                }
                else
                {
                  exists=true;//TODO:z braku czasu jest to rozwiązanie tymczasowe
                }
              },
              child: Container(
                width: mediasize.width * 0.9,
                height: 70.0,
                margin: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: zielonySlabaSGGW,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Dodaj", //TODO: przekierowanie na stronę z dodawaniem przedmiotów
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: exists ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 2000),
              onEnd: () => setState(() {
                exists = false;
              }),
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: const Text(
                  "Taki wpis już istnieje",
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
          ],
        ),
      ],
    )
    );
  }

  Future inicjalizujBudynki() async {
    listaBudynkow = await pobierzBudynki();
  }

Future createBuilding(
    String buildingName,
  ) async {
    Building building = Building(name: buildingName);
    final docBuilding = FirebaseFirestore.instance
        .collection('Building')
        .doc(buildingName);

    final json = building.toJson();
    await docBuilding.set(json);
  }

  Future createFloor(
    String buildingName,
    String floorName,
  ) async {
    Floor floor = Floor(name: floorName);
    final docFloor = FirebaseFirestore.instance
        .collection('Building')
        .doc(buildingName)
        .collection('Floors')
        .doc(floorName);

    final json = floor.toJson();
    await docFloor.set(json);
  }

  Future createRoom(
    String buildingId,
    String floorId,
    String roomName,
  ) async {
    Room room = Room(name: roomName);
    final docRoom = FirebaseFirestore.instance
        .collection('Building')
        .doc(buildingId)
        .collection('Floors')
        .doc(floorId)
        .collection('Rooms')
        .doc(roomName);

    final json = room.toJson();
    await docRoom.set(json);
  }
}
