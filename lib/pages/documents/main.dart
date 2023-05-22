import 'package:flutter/material.dart';
import 'details_page.dart';
import 'kody.dart';
import 'raporty.dart';
import 'main_page.dart';
import 'bottom_navigation_bar.dart';

void main() {
  runApp(const SearchPanel());
}

class SearchPanel extends StatelessWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      color: Color.fromRGBO(0, 50, 39, 1),
      title: 'Search Panel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(background: const Color.fromRGBO(0, 50, 39, 1)),
      ),
      home: Scaffold(
        backgroundColor:const Color.fromRGBO(0, 50, 39, 1) ,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            shadowColor: Colors.transparent,
            foregroundColor:const Color.fromRGBO(0, 50, 39, 1) ,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 25.0),
                Text(
                  "Pliki",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Open Sans",
                  ),
                ),
              ],
            ),
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
              ),
            ),
          ),
        ),

        body: Container(
          color: const Color.fromRGBO(0, 50, 39, 1),
          child: Column(
            children: [
              const CustomAppBar(),
              Expanded(
                child: const MainPage(),
              ),
              const CustomBottomNavigationBar(),
            ],
          ),
        ),
      ),
      routes: {
        '/details': (context) => const DetailsPage(),
      },
    );
  }
}

class CustomAppBar extends StatelessWidget {

  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 0,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),


    );
  }
}