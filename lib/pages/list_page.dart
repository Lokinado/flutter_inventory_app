import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:inventory_app/pages/creation_page.dart';
import 'package:inventory_app/pages/logged_page.dart';


class ListPage extends StatefulWidget {
  ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {


  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children:[
          leftSectionHeader(context),
          FutureBuilder(
              future: pobierzBudynki(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case(ConnectionState.waiting):
                    return const Text("Loading...");
                  default:
                    if(snapshot.hasError) {
                      return const Text("Błąd Połączenia z Bazą");
                    } else {
                      var buildings = snapshot.data;
                      return Expanded(
                        child: ListView(
                          children: [
                            for (var building in buildings)
                              Container(
                                color: Colors.white,
                                margin: const EdgeInsets.only(left: 10.0),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.black, // here for close state
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.black,
                                    ), // here for open state in replacement of deprecated accentColor
                                    dividerColor: Colors.transparent, // if you want to remove the border
                                  ),
                                  child: FutureBuilder(
                                      future: pobierzPietra(building),
                                      builder: (context,snapshot) {
                                        switch(snapshot.connectionState)
                                        {
                                          case (ConnectionState.waiting):
                                            return const Text("Loading...");
                                          default:
                                            if(snapshot.hasError)
                                            {
                                              return const Text("Błąd Połączenia z Bazą");
                                            }
                                            else
                                            {
                                              var floors=snapshot.data;
                                              return ExpansionTile(
                                                title: Text('Budynek $building'),
                                                textColor: Colors.black,
                                                collapsedTextColor: Colors.black,
                                                shape: const Border(),
                                                children: [
                                                  for(var floor in floors)
                                                    FutureBuilder(
                                                        future: pobierzPomieszczenia(building, floor),
                                                        builder: (context, snapshot) {
                                                          switch(snapshot.connectionState){
                                                            case (ConnectionState.waiting):
                                                              return const Text("Loading...");
                                                            default:
                                                              if(snapshot.hasError)
                                                              {
                                                                return const Text("Błąd Połączenia z Bazą");
                                                              }
                                                              else
                                                              {
                                                                var rooms=snapshot.data;
                                                                return Container(
                                                                  margin: const EdgeInsets.only(left: 12.0),
                                                                  child: Theme(
                                                                    data: Theme.of(context).copyWith(
                                                                      unselectedWidgetColor: Colors.black, // here for close state
                                                                      colorScheme: const ColorScheme.light(
                                                                        primary: Colors.black,
                                                                      ), // here for open state in replacement of deprecated accentColor
                                                                      dividerColor: Colors.transparent, // if you want to remove the border
                                                                    ),
                                                                    child: ExpansionTile
                                                                      (
                                                                      title: Text("Piętro $floor"),
                                                                      textColor: Colors.black,
                                                                      collapsedTextColor: Colors.black,
                                                                      children: [
                                                                        for(var room in rooms)
                                                                          Container(
                                                                              height: 50.0,
                                                                              width: mediaWidth.width*0.7,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(50.0),
                                                                                  color: const Color.fromARGB(217, 217, 217, 217)),
                                                                              margin: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                                                                              child: ListTile(title: Text("Sala $room"))
                                                                          ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                          }
                                                        }
                                                    ),
                                                ],
                                              );
                                            }
                                        }
                                      }
                                  ),
                                ),
                              ),

                          ],
                        ),
                      );
                    }
                }
              }
          ),
          GestureDetector(
            onTap: () => print("tu przekierowanie"),
            child: Container(
              width: mediaWidth.width*0.9,
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

  Wrap leftSectionHeader(BuildContext context) {
    return Wrap(
    children: <Widget>[
      TopBodySection(key: UniqueKey(),
        tekst: 'Pomieszczenia',size: MediaQuery.of(context).size, location: Location.left,),
      Container(
      color: zielonySGGW,
      child: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft:
            Radius.circular(75),
          ),
          //border: BorderSide
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 30,top: 9),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: const Color.fromARGB(255 ,87, 178, 122),
            child: IconButton(
              onPressed: () =>{Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=>CreationPage()))},
              icon: const Icon(Icons.add, color: Colors.white,),
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
              ),
            ),
          ),
        ),
      ),
      ),
    ],
  );
  }

  
}

