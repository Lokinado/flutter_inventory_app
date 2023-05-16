import 'package:flutter/material.dart';
import 'main.dart';
import 'details_arguments.dart';

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
