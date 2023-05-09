import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
            icon: const Icon(Icons.menu, size: 32, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.barcode_reader, size: 32, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.file_copy_sharp, size: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
