import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_app/main.dart';

void main() {
  test("Detailspage test", () {
    final detailspage = DetailsPage();
    if (detailspage == Null) {
      throw new Exception("Detailspage does not exist");
    }
    if (detailspage is int) {
      throw new Exception("Detailspage does not exist");
    }
    if (detailspage is String) {
      throw new Exception("Detailspage does not exist");
    }
    if (detailspage is Float) {
      throw new Exception("Detailspage does not exist");
    }
  });
}
