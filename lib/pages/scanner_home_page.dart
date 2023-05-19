import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/components/homebody.dart';


class ScannerHomePage extends StatefulWidget {
  const ScannerHomePage({super.key});

  @override
  State<ScannerHomePage> createState() => _ScannerHomePageState();
}

class _ScannerHomePageState extends State<ScannerHomePage> {
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
      body: Body(title: "Wybór miejsca", size: rozmiar),
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