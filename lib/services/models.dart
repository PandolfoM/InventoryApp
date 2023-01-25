import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Item {
  int cost;
  int quantity;
  String name;
  String date;

  Item({
    this.cost = 0,
    this.quantity = 0,
    this.name = '',
    this.date = '',
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Category {
  final String name;
  final List<Item> items;

  Category({
    this.name = '',
    this.items = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class User {
  String uuid;
  int total;
  Map categories;

  User({this.uuid = '', this.total = 0, this.categories = const {}});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
