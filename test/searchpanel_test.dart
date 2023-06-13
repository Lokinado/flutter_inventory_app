import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_app/main.dart';

void main() {
  test("SearchPanel test", () {
    final searchpanel = SearchPanel();
    if (searchpanel == Null) {
      throw new Exception("SearchPanel does not exist");
    }
    if (searchpanel is int) {
      throw new Exception("SearchPanel does not exist");
    }
    if (searchpanel is String) {
      throw new Exception("SearchPanel does not exist");
    }
    if (searchpanel is Float) {
      throw new Exception("SearchPanel does not exist");
    }
  });
}
