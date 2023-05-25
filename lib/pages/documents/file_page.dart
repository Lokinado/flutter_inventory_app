import 'package:flutter/material.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/pages/documents/raporty.dart';

import 'details_arguments.dart';
import 'kody.dart';

class FilePage extends StatefulWidget {
  @override
  _FilePageState createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery.of(context).size;
    return Container(
      //color: const Color.fromRGBO(0, 50, 39, 1),
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
            child: const MainPage(),
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
  String _selectedList = '';

  @override
  bool get wantKeepAlive => true;

  void _showList(String listName) {
    setState(() {
      _selectedList = listName;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color.fromRGBO(0, 50, 39, 1),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(75),
            )),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showList('Kody'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      primary: Color.fromRGBO(0, 50, 39, 1),
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
                  ElevatedButton(
                    onPressed: () => _showList('Raporty'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      primary: Color.fromRGBO(0, 50, 39, 1),
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
                ],
              ),
              _selectedList == ''
                  ? Container()
                  : Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemCount: _selectedList == 'Kody'
                            ? Kody.ilosc
                            : Raporty.ilosc,
                        itemBuilder: (context, index) {
                          final String tileTitle = _selectedList == 'Kody'
                              ? 'Kod ${index + 1}'
                              : 'Raport ${index + 1}';
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.green,
                            child: Container(
                              height: 50,
                              child: ListTile(
                                title: Text(
                                  tileTitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(title: tileTitle),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
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
        title: Text('Szczegóły: $title'),
      ),
      body: Center(
        child: Text(
          'Tytuł: $title',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
