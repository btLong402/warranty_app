// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Item {
  final String itemId;
  final String name;
  Item({
    required this.itemId,
    required this.name,
  });
  

  Item copyWith({
    String? itemId,
    String? name,
  }) {
    return Item(
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'name': name,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemId: map['itemId'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Item(itemId: $itemId, name: $name)';

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;
  
    return 
      other.itemId == itemId &&
      other.name == name;
  }

  @override
  int get hashCode => itemId.hashCode ^ name.hashCode;
}
