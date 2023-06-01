import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'package:inventory_app/pages/logged_page.dart';

class AuthPage extends StatefulWidget{
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context){
    final Size rozmiar = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // is the user logged in?
          if(!snapshot.hasData){
            return  LoggedMainPage(size: rozmiar);
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