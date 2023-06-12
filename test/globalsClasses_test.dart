import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import '../lib/database/globalsClasses.dart';

void main() {
  test('Budynek', () {
    final building = Building(name: '100000000');

    expect(building.name is String, true);
    exp(int.parse(building.name)).isFinite;
    expect(building.name, '100000000');

    expect(building.id is String, true);
    expect(building.id.isEmpty, true);
    expect(building.id, '');
  });

  test('Piętro', () {
    final floor = Floor(name: '999999999');

    expect(floor.name is String, true);
    exp(int.parse(floor.name)).isFinite;
    expect(floor.name, '999999999');

    expect(floor.id is String, true);
    expect(floor.id.isEmpty, true);
    expect(floor.id, '');
  });

  test('Pomieszczenie', () {
    final room = Room(name: '123123123');

    expect(room.name is String, true);
    exp(int.parse(room.name)).isFinite;
    expect(room.name, '123123123');

    expect(room.id is String, true);
    expect(room.id.isEmpty, true);
    expect(room.id, '');
  });

  test('Typ przedmiotu', () {
    final itemType = ItemType(name: '666666666');

    expect(itemType.name is String, true);
    exp(int.parse(itemType.name)).isFinite;
    expect(itemType.name, '666666666');

    expect(itemType.id is String, true);
    expect(itemType.id.isEmpty, true);
    expect(itemType.id, '');
  });

  test('Przedmiot', () {
    final item = Item(name: 'nazwa', comment: 'komentarz', barcode: '000000');

    expect(item.name is String, true);
    expect(item.name, 'nazwa');

    expect(item.comment is String, true);
    expect(item.comment, 'komentarz');

    expect(item.barcode is String, true);
    exp(int.parse(item.barcode)).isFinite;
    expect(item.barcode, '000000');

    expect(item.id is String, true);
    expect(item.id.isEmpty, true);
    expect(item.id, '');
  });
}
