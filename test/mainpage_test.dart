import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_app/main.dart';

void main() {
  test("MainPage test", () {
    final mainpage = MainPage();
    if (mainpage == Null) {
      throw new Exception("Mainpage does not exist");
    }
    if (mainpage is int) {
      throw new Exception("Mainpage does not exist");
    }
    if (mainpage is String) {
      throw new Exception("Mainpage does not exist");
    }
    if (mainpage is Float) {
      throw new Exception("Mainpage does not exist");
    }
  });
}
