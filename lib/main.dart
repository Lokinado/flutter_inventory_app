import 'package:flutter/material.dart';
import 'package:inventory_app/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventory_app/pages/documents/file_page.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(),
        '/details': (context) => DetailsPage(title: this.toString(),),
      },
    );
  }
}

