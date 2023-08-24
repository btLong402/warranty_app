// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:warranty_app/utils/User/user_role.dart';

class UserModel {
  final String userId;
  final String userName;
  final int contact;
  final UserRole role;
  UserModel({
    required this.userId,
    required this.userName,
    required this.contact,
    required this.role,
  });

  UserModel copyWith({
    String? userId,
    String? userName,
    int? contact,
    UserRole? role,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      contact: contact ?? this.contact,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'contact': contact,
      'role': role.index,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      contact: map['contact'] as int,
      role: UserRole.values[map['role']],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, userName: $userName, contact: $contact, role: $role)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userName == userName &&
        other.contact == contact &&
        other.role == role;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        contact.hashCode ^
        role.hashCode;
  }
}
