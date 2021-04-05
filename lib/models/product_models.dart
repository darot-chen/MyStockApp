// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

ProductModel productModelFromMap(String str) => ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
    ProductModel({
        this.products,
    });

    List<Product> products;

    factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
    };
}

class Product {
    Product({
        this.id,
        this.name,
        this.desc,
        this.quantity,
        this.sellPrice,
        this.createDate,
        this.catId,
    });

    String id;
    String name;
    String desc;
    String quantity;
    String sellPrice;
    DateTime createDate;
    List<CatId> catId;

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        quantity: json["quantity"],
        sellPrice: json["sell_price"],
        createDate: DateTime.parse(json["create_date"]),
        catId: List<CatId>.from(json["cat_id"].map((x) => CatId.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "desc": desc,
        "quantity": quantity,
        "sell_price": sellPrice,
        "create_date": createDate.toIso8601String(),
        "cat_id": List<dynamic>.from(catId.map((x) => x.toMap())),
    };
}

class CatId {
    CatId({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory CatId.fromMap(Map<String, dynamic> json) => CatId(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
