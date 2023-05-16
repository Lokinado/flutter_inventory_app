import 'package:flutter/material.dart';
import 'main_page.dart';
import 'details_arguments.dart';
import 'details_page.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Panel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(background: const Color.fromRGBO(0, 50, 39, 1)),
      ),
      home: const MainPage(),
      routes: {
        '/details': (context) => const DetailsPage(),
      },
    );
  }
}
