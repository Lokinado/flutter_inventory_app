import 'package:flutter/material.dart';
import 'details_arguments.dart';
import 'kody.dart';
import 'raporty.dart';
import 'main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _selectedList = '';

  void _showList(String listName) {
    setState(() {
      _selectedList = listName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: const Color.fromRGBO(0, 50, 39, 1),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showList('Kody'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color.fromRGBO(28, 153, 55, 1);
                        }
                        return Color.fromRGBO(26, 98, 49, 1);
                      },
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  child: const Text('Kody'),
                  
                ),
                ElevatedButton(
                  onPressed: () => _showList('Raporty'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color.fromRGBO(28, 153, 55, 1);
                        }
                        return Color.fromRGBO(26, 98, 49, 1);
                      },
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  child: const Text('Raporty'),
                ),
              ],
            ),
            _selectedList == ''
    ? Container()
    : Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount:
              _selectedList == 'Kody' ? Kody.ilosc : Raporty.ilosc,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 60,
                width: 50,
                child: ListTile(
                  title: Text(
                    _selectedList == 'Kody'
                        ? 'Kod ${index + 1}'
                        : 'Raport ${index + 1}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: DetailsArguments(
                        title: _selectedList == 'Kody'
                            ? 'Kod ${index + 1}'
                            : 'Raport ${index + 1}',
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
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
    elevation: 0,
    actions: [],
  );
}
