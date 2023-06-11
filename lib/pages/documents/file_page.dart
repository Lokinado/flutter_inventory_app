import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/database/list_Buildings.dart';
import 'package:inventory_app/components/color_palette.dart';

class FilePage extends StatefulWidget {
  @override
  _FilePageState createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TopBodySection(
            key: UniqueKey(),
            tekst: "Dokumenty",
            size: rozmiar,
            location: Location.right,
          ),
          Expanded(
            child: MainPage(),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  int _selectedIndex = -1;

  @override
  bool get wantKeepAlive => true;

  void _selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color.fromRGBO(0, 50, 39, 1),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(75),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 30, 00, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectIndex(0),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor:
                          _selectedIndex == 0 ? zielonySGGW : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Raporty',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectIndex(1),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 50),
                      backgroundColor:
                          _selectedIndex == 1 ? zielonySGGW : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Kody',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              ),
              _selectedIndex >= 0
                  ? _selectedIndex == 0
                      ? Expanded(
                          child: ListRaportsClass(),
                        )
                      : Expanded(
                          child: ListBuildingsClass(),
                        )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListBuildingsClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListBuildings(),
    );
  }
}

class ListRaportsClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('ListRaports'),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String title;

  DetailsPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zielonySGGW,
        toolbarHeight: 80,
        title: Text('Szczegóły: $title'),
      ),
      body: Center(
        child: Text(
          'Tytuł: $title',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
