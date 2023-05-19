import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/components/homebody.dart';
import '../components/bottom_navigation_bar.dart';


class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  //sign user out method
  void signUserOut() async{
    await FirebaseAuth.instance.signOut();
  }
 // this methon in the futher will be used to sign the user out
  @override
  Widget build(BuildContext context){
    final Size rozmiar = MediaQuery.of(context).size;

    return Scaffold(
        appBar: buildAppBar(),
        body: Body(title: "Dokumenty",size: rozmiar),
        //bottomNavigationBar: CustomBottomNavigationBar(size: rozmiar)
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
      elevation: 0,
      actions: [
        IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout))
      ],
    );
  }
}