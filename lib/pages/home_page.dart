import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/pages/scanner_home_page.dart';
import 'package:inventory_app/pages/add_page.dart';
import 'package:inventory_app/pages/file_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selected = 0;
  final screens = [
    AddPage(),
    ScannerHomePage(),
    FilePage()
  ];


  //sign user out method
  void signUserOut() async{
    await FirebaseAuth.instance.signOut();
  }
  // this methon in the futher will be used to sign the user out
  @override
  Widget build(BuildContext context){
    final Size rozmiar = MediaQuery.of(context).size;


    return screens[selected];
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

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key, required this.size}) : super(key: key);

  final Size size;


  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height*0.1, // Bottom bar is 10% of the height
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 35,
            color: const Color.fromRGBO(0, 50, 39, 1).withOpacity(0.38),
          ),
        ],
        color: const Color.fromRGBO(0, 50, 39, 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),


      // Displaying icons
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          IconButton(
            //  When pressed, change which icon is "active"
            onPressed: () {setState(() { _HomePageState().selected = 0; debugPrint(_HomePageState().selected.toString());});},
            icon: Icon(
                Icons.add_circle_outlined, size: 32,
                color: Color.fromARGB(_HomePageState().selected==0? 255 : 100, 255, 255, 255)),
          ),

          IconButton(
            onPressed: () {setState(() { _HomePageState().selected = 1;  debugPrint(_HomePageState().selected.toString());});},
            icon: Icon(
                Icons.camera_alt_rounded, size: 32,
                color: Color.fromARGB(_HomePageState().selected==1? 255 : 100, 255, 255, 255)),
          ),

          IconButton(
            onPressed: () {setState(() { _HomePageState().selected = 2;  debugPrint(_HomePageState().selected.toString());});},
            icon:  Icon(
                Icons.summarize_outlined, size: 32,
                color: Color.fromARGB(_HomePageState().selected==2? 255 : 100, 255, 255, 255)),
          ),
        ],
      ),
    );
  }
}
