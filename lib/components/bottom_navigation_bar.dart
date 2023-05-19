import 'package:flutter/material.dart';
import 'package:inventory_app/pages/scanner_home_page.dart';
import 'package:inventory_app/pages/scanner/scanner_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height*0.1, // Bottom bar is 10% of the height
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outlined, size: 32, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.camera_alt_rounded, size: 32, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.summarize_outlined, size: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
