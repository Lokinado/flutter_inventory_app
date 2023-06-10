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
  final String type;
  Item({
    this.id = '',
    required this.name,
    required this.comment,
    required this.barcode,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'comment': comment,
        'barcode': barcode,
        'type': type,
      };

  static Item fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        comment: json['comment'],
        barcode: json['barcode'],
        type: json['type'],
      );
}

class SpecificItemType {
  String id;
  final String name;
  double price;
  // DateTime dateOfPurchase;

  SpecificItemType({
    this.id = '',
    required this.name,
    required this.price,
    // required this.dateOfPurchase,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        // 'dateOfPurchase': dateOfPurchase,
      };

  static SpecificItemType fromJson(Map<String, dynamic> json) =>
      SpecificItemType(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        // dateOfPurchase: json['dateOfPurchase'],
        // comment: json['comment'],
        // barcode: json['barcode'],
      );
}
