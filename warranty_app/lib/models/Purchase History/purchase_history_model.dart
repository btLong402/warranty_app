// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PurchaseHistoryModel {
  final String? customerId;
  final List<String>? productIdList;
  PurchaseHistoryModel({
    this.customerId,
    this.productIdList,
  });

  PurchaseHistoryModel copyWith({
    String? customerId,
    List<String>? productIdList,
  }) {
    return PurchaseHistoryModel(
      customerId: customerId ?? this.customerId,
      productIdList: productIdList ?? this.productIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'productIdList': productIdList,
    };
  }

  factory PurchaseHistoryModel.fromMap(Map<String, dynamic> map) {
    return PurchaseHistoryModel(
      customerId:
          map['customerId'] != null ? map['customerId'] as String : null,
      productIdList: map['productIdList'] != null
          ? List<String>.from((map['productIdList'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseHistoryModel.fromJson(String source) =>
      PurchaseHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PurchaseHistoryModel(customerId: $customerId, productIdList: $productIdList)';

  @override
  bool operator ==(covariant PurchaseHistoryModel other) {
    if (identical(this, other)) return true;

    return other.customerId == customerId &&
        listEquals(other.productIdList, productIdList);
  }

  @override
  int get hashCode => customerId.hashCode ^ productIdList.hashCode;
}
