import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'scanner_home_page.dart';
class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // is the user logged in?
          if(snapshot.hasData){
            return const HomePage();
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