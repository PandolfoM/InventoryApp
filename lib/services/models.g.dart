// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      cost: json['cost'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      date: json['date'] as String? ?? '',
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'cost': instance.cost,
      'quantity': instance.quantity,
      'name': instance.name,
      'date': instance.date,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      name: json['name'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
      'items': instance.items,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      uuid: json['uuid'] as String? ?? '',
      categories: json['categories'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'categories': instance.categories,
    };
