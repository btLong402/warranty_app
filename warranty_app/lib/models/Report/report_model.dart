// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:warranty_app/utils/constant.dart';

class Report {
  final String? reportId;
  final String? customerId;
  final String? productId;
  Status? status;
  final DateTime? createAt;
  final String? description;
  final String? supportNow;
  Report({
    this.reportId,
    this.customerId,
    this.productId,
    this.status,
    this.createAt,
    this.description,
    this.supportNow,
  });

  Report copyWith({
    String? reportId,
    String? customerId,
    String? productId,
    Status? status,
    DateTime? createAt,
    String? description,
    String? supportNow,
  }) {
    return Report(
      reportId: reportId ?? this.reportId,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      status: status ?? this.status,
      createAt: createAt ?? this.createAt,
      description: description ?? this.description,
      supportNow: supportNow ?? this.supportNow,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reportId': reportId,
      'customerId': customerId,
      'productId': productId,
      'status': status!.index,
      'createAt': createAt!.millisecondsSinceEpoch,
      'supportNow': supportNow,
      'description': description,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      reportId: map['reportId'] as String,
      customerId: map['customerId'] as String,
      productId: map['productId'] as String,
      status: Status.values[map['status']],
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      description: map['description'] as String,
      supportNow: map['supportNow'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Report(reportId: $reportId, customerId: $customerId, productId: $productId, status: $status, createAt: $createAt, description: $description)';
  }

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;

    return other.reportId == reportId &&
        other.customerId == customerId &&
        other.productId == productId &&
        other.status == status &&
        other.createAt == createAt &&
        other.description == description &&
        other.supportNow == supportNow;
  }

  @override
  int get hashCode {
    return reportId.hashCode ^
        customerId.hashCode ^
        productId.hashCode ^
        status.hashCode ^
        createAt.hashCode ^
        description.hashCode ^
        supportNow.hashCode;
  }
}
