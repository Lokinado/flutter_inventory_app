import 'package:flutter/material.dart';
import 'package:inventory_app/pages/documents/file_page.dart';
import 'package:inventory_app/pages/scanner/pick_place_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/pages/adding/add_page.dart';

class loggedMainPage extends StatefulWidget {
  const loggedMainPage({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<loggedMainPage> createState() => _loggedMainPageState();
}

class _loggedMainPageState extends State<loggedMainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var _selectedPageIndex = 1;
  late PageController _pageController;
  List<Widget> _pages = [AddPage(), PickPlace(), FilePage()];

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedPageIndex);

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the super build method is called
    return Scaffold(
      appBar: buildAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        pageSnapping: true,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: widget.size.height * 0.11,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedPageIndex,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 32,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.white60,
              size: 30,
            ),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: const Color.fromRGBO(0, 50, 39, 1),
            onTap: (selectedPageIndex) {
              setState(() {
                _selectedPageIndex = selectedPageIndex;
                _pageController.jumpToPage(selectedPageIndex);
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outlined),
                label: "addpage",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_rounded),
                label: "Camera",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_copy),
                label: "Files",
              ),
            ],
          ),

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