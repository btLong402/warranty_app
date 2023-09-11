// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:warranty_app/utils/constant.dart';

class UserModel {
  final String? userId;
  final String? email;
  final String? userName;
  final String? contact;
  final UserRole? role;
  UserModel({
    this.email,
    this.userId,
    this.userName,
    this.contact,
    this.role,
  });

  UserModel copyWith({
    String? email,
    String? userId,
    String? userName,
    String? contact,
    UserRole? role,
  }) {
    return UserModel(
      email: email ?? this.email,
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
      'role': role!.index,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      contact: map['contact'] as String,
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
