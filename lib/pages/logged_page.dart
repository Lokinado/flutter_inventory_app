import 'package:flutter/material.dart';
import 'package:inventory_app/pages/documents/file_page.dart';
import 'package:inventory_app/pages/scanner/scan_place_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/pages/adding/add_page.dart';

class loggedMainPage extends StatefulWidget {
  const loggedMainPage({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<loggedMainPage> createState() => _loggedMainPageState();
}

class _loggedMainPageState extends State<loggedMainPage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  var selected = 1;


  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Creatino and dispose of the element

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this,
        initialIndex: selected);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //  Main page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),  // With logged button

      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          AddPage(),
          WyborMiejsca(),
          FilePage(),
        ],
      ),


      bottomNavigationBar: Container(
        height: widget.size.height * 0.1, // Bottom bar is 10% of the height
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

        //  The bottm bar itself
        child: TabBar(
          indicator: BoxDecoration(),
          controller: _tabController,
          onTap: (index) {
            setState(() {
              selected = index;
            });
          },
          tabs: <Widget>[

            //  Addition page
            Tab(
              icon: Icon(
                Icons.add_circle_outlined,
                size: 32,
                color: Color.fromARGB(selected == 0 ? 255 : 100, 255, 255, 255),
              ),
            ),

            // Scanner page
            Tab(
              icon: Icon(
                Icons.camera_alt_rounded,
                size: 32,
                color: Color.fromARGB(selected == 1 ? 255 : 100, 255, 255, 255),
              ),
            ),

            // File Page
            Tab(
              icon: Icon(
                Icons.file_copy_sharp,
                size: 32,
                color: Color.fromARGB(selected == 2 ? 255 : 100, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Custom AppBar
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
      elevation: 0,
      toolbarHeight: 60,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end, // Change the alignment here
          children: [
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ],
    );
  }

}

