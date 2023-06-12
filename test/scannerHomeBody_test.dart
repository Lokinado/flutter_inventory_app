import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/components/topbodysection.dart';
import 'package:inventory_app/prefab/homebody.dart';

void main() {
  group('ScannerHomeBody', () {
    test('Tworzenie obiektu', () async {
      const locationTest = Location.center;
      const sizeTest = Size(250, 100);
      const titleTest = "Test";

      const SHBTest = ScannerHomeBody(
          title: titleTest, size: sizeTest, location: locationTest);

      expect(SHBTest.location, locationTest);
      expect(SHBTest.size, sizeTest);
      expect(SHBTest.title, titleTest);
    });
    test('Wymiary obiektu', () async {
      const locationTest = Location.center;
      const sizeTest = Size(250, 100);
      const titleTest = "Test";

      const SHBTest = ScannerHomeBody(
          title: titleTest, size: sizeTest, location: locationTest);

      expect(SHBTest.size.aspectRatio, sizeTest.aspectRatio);
      expect(SHBTest.size.height, sizeTest.height);
      expect(SHBTest.size.width, sizeTest.width);
    });
    test('Lokalizacja obiektu', () async {
      const locationTest = Location.center;
      const sizeTest = Size(250, 100);
      const titleTest = "Test";

      const SHBTest = ScannerHomeBody(
          title: titleTest, size: sizeTest, location: locationTest);

      expect(SHBTest.location.toString(), locationTest.toString());
      expect(SHBTest.location.index, locationTest.index);
      expect(SHBTest.location.name, locationTest.name);
      expect(SHBTest.location.hashCode, locationTest.hashCode);
    });
  });
}