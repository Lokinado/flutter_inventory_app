import 'package:flutter/material.dart';

import 'my_button.dart';

class NoConnectionPage extends StatelessWidget {
  final Function() checkConnection;

  const NoConnectionPage({super.key, required this.checkConnection});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Brak połączenia z internetem',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 30),
          const Icon(
            Icons.wifi_off,
            size: 50,
          ),
          const SizedBox(height: 20),
          MyButton(
            onTap: () {
              checkConnection();
            },
            display: "Odśwież",
          ),
        ],
      ),
    );
    ;
  }
}
