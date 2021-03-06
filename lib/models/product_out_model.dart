// To parse this JSON data, do
//
//     final productOutModel = productOutModelFromMap(jsonString);

import 'dart:convert';

ProductOutModel productOutModelFromMap(String str) => ProductOutModel.fromMap(json.decode(str));

String productOutModelToMap(ProductOutModel data) => json.encode(data.toMap());

class ProductOutModel {
    ProductOutModel({
        this.productsOut,
    });

    List<ProductsOut> productsOut;

    factory ProductOutModel.fromMap(Map<String, dynamic> json) => ProductOutModel(
        productsOut: List<ProductsOut>.from(json["products_out"].map((x) => ProductsOut.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "products_out": List<dynamic>.from(productsOut.map((x) => x.toMap())),
    };
}

class ProductsOut {
    ProductsOut({
        this.id,
        this.date,
        this.quantityOut,
        this.products,
    });

    String id;
    DateTime date;
    String quantityOut;
    List<Product> products;

    factory ProductsOut.fromMap(Map<String, dynamic> json) => ProductsOut(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        quantityOut: json["quantity_out"],
        products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "date": date.toIso8601String(),
        "quantity_out": quantityOut,
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
