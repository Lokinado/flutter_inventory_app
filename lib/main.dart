import 'package:flutter/material.dart';
import 'pages/list_page.dart';
import 'package:inventory_app/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  
  class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: AuthPage( ),
    );
    }
  }
}