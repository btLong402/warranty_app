// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:warranty_app/models/Item/item_model.dart';

class Product {
  final int productId;
  final String name;
  final List<Item> itemList;
  Product({
    required this.productId,
    required this.name,
    required this.itemList,
  });
  

  Product copyWith({
    int? productId,
    String? name,
    List<Item>? itemList,
  }) {
    return Product(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      itemList: itemList ?? this.itemList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'itemList': itemList.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] as int,
      name: map['name'] as String,
      itemList: List<Item>.from((map['itemList'] as List<int>).map<Item>((x) => Item.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Product(productId: $productId, name: $name, itemList: $itemList)';

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      other.name == name &&
      listEquals(other.itemList, itemList);
  }

  @override
  int get hashCode => productId.hashCode ^ name.hashCode ^ itemList.hashCode;
}
