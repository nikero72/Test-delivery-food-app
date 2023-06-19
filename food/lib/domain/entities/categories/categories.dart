import 'package:json_annotation/json_annotation.dart';

part 'categories.g.dart';

@JsonSerializable()
class Categories {
  @JsonKey(name: 'сategories')
  final List<Category> categoryList;

  Categories(
    this.categoryList
      );

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable()
class Category {
  final int id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;

  Category(
    this.id,
    this.name,
    this.imageUrl
  );

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}