import 'package:flutter/material.dart';

void main() {
  runApp(const SearchPanel());
}

class SearchPanel extends StatelessWidget {
   const SearchPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Panel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(background: Colors.green[900]),
      ),
      home: const MainPage(),
      routes: {
        '/details': (context) => const DetailsPage(),
      },
    );
  }
}

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

      appBar: AppBar(
      
        backgroundColor: Colors.white,
        title: const Text(
          "Pliki",
          
          style: TextStyle(
      color: Colors.black,
      fontSize: 24, // ustawiamy rozmiar czcionki na 24
      fontWeight: FontWeight.bold, // ustawiamy pogrubienie tekstu
      fontFamily: "Open Sans" // ustawiamy styl tekstu na pochylony
    ),
        ),
      ),


      body: Container(
        color: Colors.green.shade800,
        padding: const EdgeInsets.all(25),
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  
                  onPressed: () => _showList('Kody'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(150, 50)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 25))
                  ),
                  child: const Text('Kody'),
                  
                ),

                ElevatedButton(
                  onPressed: () => _showList('Raporty'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(150, 50)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 25))
                  ),
                  child: const Text('Raporty'),
                ),

              ],

            ),
            const SizedBox(height:16,width: 80,),
            
            _selectedList == ''
                ? Container()
                : Expanded(

                    child: ListView.builder(
                      itemCount: _selectedList == 'Kody' ? Kody.ilosc : Raporty.ilosc,
                      itemBuilder: (context, index) {

                        return Card(
                         
                           elevation: 4, 
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), 
                          ),
                          child: ListTile(
                          
                            title: Text(
                              _selectedList == 'Kody'
                                  ? 'Kod ${index + 1}'
                                  : 'Raport ${index + 1}',
                                  textAlign: TextAlign.center, // wyśrodkowanie tekstu
                            style: const TextStyle(
                              fontSize: 18, // zmiana wielkości czcionki
                              fontWeight: FontWeight.bold, // zmiana grubości czcionki
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

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as DetailsArguments;

    return Scaffold(
            appBar: AppBar(
        backgroundColor: Colors.white,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    color: Colors.black,
    onPressed: () {
      Navigator.pop(context);
    },


  ),
        title: Text(
          args.title,
          style: const TextStyle(color: Colors.black),
        ),

),
      body: Center(
        child: Text('Szczegóły ${args.title}'),
      ),

    );

  }

}

class DetailsArguments {
  final String title;

  DetailsArguments({required this.title});
}

class Kody {
  static int ilosc= 20;
  static String getTitle(int index) {
    return 'Kod ${index + 1}';
  }
}

class Raporty {
  static int ilosc= 25;
  static String getTitle(int index) {
    return 'Raport ${index + 1}';
  }
}
