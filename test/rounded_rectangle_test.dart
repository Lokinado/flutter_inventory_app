import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_app/components/rounded_rectangle.dart';

void main() {
  test("Textbox test", () {
    double top = 100;
    double right = 50;
    double width = 200;
    final textbox = roundedRectangleTextBox(
        text: "test", top: top, right: right, width: width);
    expect(textbox.text, "test");

    expect(textbox.top, 100);

    expect(textbox.right, 50);

    expect(textbox.width, 200);
  });

  test("Button test", () {
    double top = 10;
    double right = 15;
    double width = 36;
    dynamic destination = "test";
    final button = roundedRectangleButton(
        destination: destination,
        napis: "test",
        top: top,
        right: right,
        width: width);
    expect(button.destination, "test");

    expect(button.napis, "test");

    expect(button.top, 10);

    expect(button.right, 15);

    expect(button.width, 36);
  });
}
