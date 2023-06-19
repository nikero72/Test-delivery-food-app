// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dishes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dishes _$DishesFromJson(Map<String, dynamic> json) => Dishes(
      (json['dishes'] as List<dynamic>)
          .map((e) => Dish.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DishesToJson(Dishes instance) => <String, dynamic>{
      'dishes': instance.dishList,
    };

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      json['id'] as int,
      json['name'] as String,
      json['price'] as int,
      json['weight'] as int,
      json['description'] as String,
      json['image_url'] as String,
      (json['tegs'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'weight': instance.weight,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'tegs': instance.tags,
    };
