import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'scanner_home_page.dart';
import 'package:inventory_app/pages/home_page.dart';


class AuthPage extends StatefulWidget{
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // is the user logged in?
          if(snapshot.hasData){
            return  HomePage();
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