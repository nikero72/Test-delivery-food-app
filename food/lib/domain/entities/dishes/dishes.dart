import 'package:json_annotation/json_annotation.dart';

part 'dishes.g.dart';


@JsonSerializable()
class Dishes {
  @JsonKey(name: 'dishes')
  final List<Dish> dishList;

  Dishes(
      this.dishList
  );

  factory Dishes.fromJson(Map<String, dynamic> json) => _$DishesFromJson(json);
  Map<String, dynamic> toJson() => _$DishesToJson(this);

}

@JsonSerializable()
class Dish {
  final int id;
  final String name;
  final int price;
  final int weight;
  final String description;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'tegs')
  final List<String> tags;

  Dish(
    this.id,
    this.name,
    this.price,
    this.weight,
    this.description,
    this.imageUrl,
    this.tags
  );

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);
}