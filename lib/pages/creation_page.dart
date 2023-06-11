import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/components/smalltopbodysection.dart';
import 'package:inventory_app/components/element_styling.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:list_picker/list_picker.dart';
import 'package:inventory_app/components/user_input_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/database/globalsClasses.dart';
class CreationPage extends StatefulWidget {
  CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  @override
  List<String> listaBudynkow = [];
  List<String> listaPieter = [];
  List<String> listaPomieszczen = [];

  bool exists = false;

  String budynek = "";

  String pietro = "";

  String pomieszczenie = "";

  Widget build(BuildContext context) {
    final mediasize = MediaQuery.of(context).size;
    double numberBoxSize = 60;
    double szerokoscPrzycisku = mediasize.width - 120;
    inicjalizujBudynki();
    return Scaffold(
        body: Column(
      children: [
        TopBodySection(key: UniqueKey(), size: mediasize, tekst: "Dodawanie"),
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
                      String? wyborBudynku = await showPickerDialog(
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
              ]),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                          String? wyborPietra = await showPickerDialog(
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
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        children: [
                          /// Zielony kwadracik z numerem pomieszczenie
                          Container(
                            alignment: Alignment.center,
                            width: numberBoxSize,
                            height: numberBoxSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(roundness),
                                color: pietro != ""
                                    ? zielonySGGW
                                    : zielonySlabaSGGW),
                            child: Text(
                              pomieszczenie,
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
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
                                  String? wyborPomieszczenia =
                                      await showUserInput(
                                    context: context,
                                    label: "Pomieszczenie",
                                  );
                                  if (wyborPomieszczenia != null && !listaPomieszczen.contains(wyborPomieszczenia)) {
                                    setState(() {
                                      exists = false;
                                      if (pomieszczenie != wyborPomieszczenia) {
                                        pomieszczenie = wyborPomieszczenia;
                                      }
                                    });
                                  }
                                  else
                                  {//TODO: komunikat że taki pokój istnieje
                                    setState((){
                                      exists = true;
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
                createRoom(budynek, pietro, pomieszczenie);
                Navigator.pop(context);
              },
            child: Container(
              width: mediasize.width*0.9,
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
                  "Dodaj Pomieszczenie",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          ],
          
        )
      ],
    ));
  }

  Future inicjalizujBudynki() async {
    listaBudynkow = await pobierzBudynki();
  }

  Future createRoom(String building, String floor, String rooom) async {
    final docRoom = FirebaseFirestore.instance
        .collection('Building')
        .doc(building)
        .collection('Floor')
        .doc(floor)
        .collection('Rooms')
        .doc();
        Room room = Room(name: rooom);
    room.id = docRoom.id;

    final json = room.toJson();
    await docRoom.set(json);
  }
}
