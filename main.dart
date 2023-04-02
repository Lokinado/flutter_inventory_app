import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inwentaryzacja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/reports': (context) => ReportsPage(),
        '/codes': (context) => CodesPage(),

      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wyszukiwanie'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Co chcesz zobaczyć?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reports');
              },
              child: Text('Lista raportów'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/codes');
              },
              child: Text('Lista kodów'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  final List<String> reports = [
    'Raport 1',
    'Raport 2',
    'Raport 3',
    'Raport 4',
    'Raport 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista raportów'),
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reports[index]),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: DetailsArguments(title: reports[index]),
              );
            },
          );
        },
      ),
    );
  }
}
class DetailsArguments {
  final String title;

  DetailsArguments({required this.title});
}
class CodesPage extends StatelessWidget {
  final List<String> codes = [
    'Kod 1',
    'Kod 2',
    'Kod 3',
    'Kod 4',
    'Kod 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista kodów'),
      ),
      body: ListView.builder(
        itemCount: codes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(codes[index]),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: DetailsArguments(title: codes[index]),
              );
            },
          );
        },
      ),
    );
  }
}