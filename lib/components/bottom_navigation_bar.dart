import 'package:flutter/material.dart';
import 'package:inventory_app/components/homebody.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var selected = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          FirstPage(),
          SecondPage(),
          ThirdPage(),
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
        child: TabBar(
          indicator: BoxDecoration(),
          controller: _tabController,
          onTap: (index) {
            setState(() {
              selected = index;
            });
          },
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.add_circle_outlined,
                size: 32,
                color: Color.fromARGB(selected == 0 ? 255 : 100, 255, 255, 255),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.camera_alt_rounded,
                size: 32,
                color: Color.fromARGB(selected == 1 ? 255 : 100, 255, 255, 255),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.summarize_outlined,
                size: 32,
                color: Color.fromARGB(selected == 2 ? 255 : 100, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
      elevation: 0,
      toolbarHeight: 80,
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

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  @override
  Widget build(BuildContext context) {
    final Size rozmiar = MediaQuery
        .of(context)
        .size;
    return Scaffold(body: Body(title: "Pierwsza", size: rozmiar));
  }

}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('Second Page'),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('Third Page'),
      ),
    );
  }
}

