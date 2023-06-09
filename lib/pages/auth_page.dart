import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/components/connectionChecker.dart';
import 'package:inventory_app/components/my_button.dart';
import '../components/no_connection.dart';
import 'login_page.dart';
import 'package:inventory_app/pages/logged_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    bool connected = await ConnectionChecker.hasConnection();
    setState(() {
      isConnected = connected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if the app does not have connection to the internet
          // return a message and refresh every 5 seconds. Add a refresh button
          // to refresh the page manually
          if (!isConnected) {
            return NoConnectionPage(checkConnection: checkConnection);
          }
          // is the user logged in?
          else if (snapshot.hasData) {
            return LoggedMainPage(size: rozmiar);
          }

          // user is NOT logged in
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
