// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:warranty_app/utils/constant.dart';

class Report {
  final int? reportId;
  final String? customerId;
  final int? productId;
  Status? status;
  final DateTime? createAt;
  final String? description;
  Report({
    this.reportId,
    this.customerId,
    this.productId,
    this.status,
    this.createAt,
    this.description,
  });

  Report copyWith({
    int? reportId,
    String? customerId,
    int? productId,
    Status? status,
    DateTime? createAt,
    String? description,
  }) {
    return Report(
      reportId: reportId ?? this.reportId,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      status: status ?? this.status,
      createAt: createAt ?? this.createAt,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reportId': reportId,
      'customerId': customerId,
      'productId': productId,
      'status': status!.index,
      'createAt': createAt!.millisecondsSinceEpoch,
      'description': description,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      reportId: map['reportId'] as int,
      customerId: map['customerId'] as String,
      productId: map['productId'] as int,
      status: Status.values[map['status']],
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      description: map['description'] as String,
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
        other.description == description;
  }

  @override
  int get hashCode {
    return reportId.hashCode ^
        customerId.hashCode ^
        productId.hashCode ^
        status.hashCode ^
        createAt.hashCode ^
        description.hashCode;
  }
}
