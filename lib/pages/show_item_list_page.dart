import 'package:flutter/material.dart';
import 'package:inventory_app/components/color_palette.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/components/custom_app_bar.dart';
import 'package:inventory_app/database/place_to_list.dart';
import 'package:inventory_app/pages/add_item_page.dart';

class ShowItemListPage extends StatefulWidget {  
  @override
  const ShowItemListPage({super.key, 
  required this.building,
  required this.floor,
  required this.room,
  });
  final String building;
  final String floor;
  final String room;
  
  State<ShowItemListPage> createState() => _ShowItemListPageState();
}

class _ShowItemListPageState extends State<ShowItemListPage> {
  
  bool initalized=false;

  Map<String, Map<String,String>> itemTypesList = {};
  @override
   Widget build(BuildContext context) {
    final mediaSize=MediaQuery.of(context).size;
    if(!initalized){
    getItemTypes();//pobiera dane o przedmiotach w pomieszczeniu, jeśli jeszcze tego nie zrobił
    }
    return Scaffold(
      appBar: buildAppBar(context),
      
      body: Column(
        children: [
          TopBodySection(key: UniqueKey(), size: mediaSize, tekst: "Pomieszczenie ${widget.room}", location: Location.center),
          //biggest Container, list of items inside
          Container(
            width: mediaSize.width*0.9,
            height: mediaSize.height*0.6,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: ListView(
              children: itemTypesList.keys.map((item) {
                return Container(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                                    unselectedWidgetColor:
                                        zielonySGGW, // here for close state
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.black,
                                    ), // here for open state in replacement of deprecated accentColor
                                    dividerColor: Colors
                                        .transparent, // if you want to remove the border
                                  ),
                    child: ExpansionTile(
                      title: Text(item),
                      children:[
                        for(var code in itemTypesList[item]!.keys.toList())
                       Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                         child: ListTile(title: Text(code),
                         //onTap: , TODO:wyświetlanie komentarza w formie alertu
                         ),
                       ),
                      ]
                      ),
                  ),
                );
              }).toList()
            ),
          ),
              GestureDetector(
                onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddItemPage(building: widget.building, floor: widget.floor, room: widget.room,)));
                    setState(() {initalized=false;});
                  },
                child: Container(
                width: mediaSize.width * 0.9,
                height: 70.0,
                margin: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: zielonySlabaSGGW,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: const Icon(Icons.add),
                ),
              ),
        ]
        ),
    );
  }
  Future getItemTypes() async {
    itemTypesList = await przedmiotyWKategoriach(widget.building, widget.floor, widget.room);
  
    setState(() {
      itemTypesList=itemTypesList;
      initalized=true;
    });
  }
  }

