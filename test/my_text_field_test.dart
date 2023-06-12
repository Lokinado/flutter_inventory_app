import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_app/components/my_text_field.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() {
  test("TextField test", () {
    final field = MyTextField(
        controller: ControllerCallback, hintText: "test", obscureText: true);
    expect(field.controller, ControllerCallback);

    expect(field.hintText, "test");

    expect(field.obscureText, true);
  });
}
