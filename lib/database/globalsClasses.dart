import 'package:cloud_firestore/cloud_firestore.dart';

class Building {
  String id;
  final String name;
  Building({
    this.id = '',
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static Building fromJson(Map<String, dynamic> json) => Building(
        id: json['id'],
        name: json['name'],
      );
}

class Floor {
  String id;
  final String name;
  Floor({
    this.id = '',
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static Floor fromJson(Map<String, dynamic> json) => Floor(
        id: json['id'],
        name: json['name'],
      );
}

class Room {
  String id;
  final String name;
  Room({
    this.id = '',
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static Room fromJson(Map<String, dynamic> json) => Room(
        id: json['id'],
        name: json['name'],
      );
}

class ItemType {
  String id;
  final String name;
  ItemType({
    this.id = '',
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static ItemType fromJson(Map<String, dynamic> json) => ItemType(
        id: json['id'],
        name: json['name'],
      );
}

class Item {
  String id;
  final String name;
  final String comment;
  final String barcode; // id.floor + id.room + id.item i tyle

  final Timestamp date_created;

  Item({
    this.id = '',
    required this.name,
    required this.comment,
    required this.barcode,
    required this.date_created,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'comment': comment,
        'barcode': barcode,
        'dateCreated': date_created,
      };

  static Item fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        comment: json['comment'],
        barcode: json['barcode'],
        date_created: json['dateCreated'],
      );
}
