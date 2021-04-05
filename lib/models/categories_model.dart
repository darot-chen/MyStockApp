// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromMap(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromMap(String str) => CategoryModel.fromMap(json.decode(str));

String categoryModelToMap(CategoryModel data) => json.encode(data.toMap());

class CategoryModel {
    CategoryModel({
        this.categories,
    });

    List<Category> categories;

    factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
