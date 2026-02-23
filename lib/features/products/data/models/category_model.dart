import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final String slug;
  final String name;
  final String url;

  CategoryModel({required this.slug, required this.name, required this.url});

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(slug: slug, name: name, url: url);
  }
}
