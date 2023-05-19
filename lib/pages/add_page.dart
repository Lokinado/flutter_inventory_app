import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/components/homebody.dart';
import 'logged_page.dart';


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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
        body: Body(title: "Dodawanie",size: rozmiar),
        bottomNavigationBar: loggedMainPage(size: rozmiar)
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