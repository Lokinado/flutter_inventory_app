import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
      elevation: 0,
      toolbarHeight: 60,
      actions: const [
        Column(
          mainAxisAlignment: MainAxisAlignment.end, // Change the alignment here
          children: [
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ],
    );
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }