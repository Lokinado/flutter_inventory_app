import 'package:flutter/material.dart';
import 'package:inventory_app/components/smalltopbodysection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TopBodySection', () {
    test('Tworzenie obiektu', () async {
      const VKTest = ValueKey("Tekst");
      const sizeTest = Size(250, 100);
      const tekstTest = "Test";

      const TBSTest =
      TopBodySection(key: VKTest, size: sizeTest, tekst: tekstTest);

      expect(TBSTest.tekst, tekstTest);
      expect(TBSTest.size, sizeTest);
      expect(TBSTest.key, VKTest);
    });
    test('Wymiary obiektu', () async {
      const VKTest = ValueKey("Tekst");
      const sizeTest = Size(250, 100);
      const tekstTest = "Test";

      const TBSTest =
      TopBodySection(key: VKTest, size: sizeTest, tekst: tekstTest);

      expect(TBSTest.size.aspectRatio, sizeTest.aspectRatio);
      expect(TBSTest.size.height, sizeTest.height);
      expect(TBSTest.size.width, sizeTest.width);
    });
    test('Klucz obiektu', () async {
      const VKTest = ValueKey("Tekst");
      const sizeTest = Size(250, 100);
      const tekstTest = "Test";

      const TBSTest =
      TopBodySection(key: VKTest, size: sizeTest, tekst: tekstTest);

      expect(TBSTest.key.toString(), VKTest.toString());
      expect(TBSTest.key.hashCode, VKTest.hashCode);
    });
  });
}