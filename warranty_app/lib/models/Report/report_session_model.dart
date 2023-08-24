// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'dart:convert';

import 'package:warranty_app/utils/status.dart';

class ReportSession {
  final int reportSessionId;
  final int reportId;
  final String supportId;
  final DateTime createAt;
  final String description;
  Status status;
  ReportSession({
    required this.reportSessionId,
    required this.reportId,
    required this.supportId,
    required this.createAt,
    required this.description,
    required this.status,
  });

 

  ReportSession copyWith({
    int? reportSessionId,
    int? reportId,
    String? supportId,
    DateTime? createAt,
    String? description,
    Status? status,
  }) {
    return ReportSession(
      reportSessionId: reportSessionId ?? this.reportSessionId,
      reportId: reportId ?? this.reportId,
      supportId: supportId ?? this.supportId,
      createAt: createAt ?? this.createAt,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reportSessionId': reportSessionId,
      'reportId': reportId,
      'supportId': supportId,
      'createAt': createAt.millisecondsSinceEpoch,
      'description': description,
      'status': status.index,
    };
  }

  factory ReportSession.fromMap(Map<String, dynamic> map) {
    return ReportSession(
      reportSessionId: map['reportSessionId'] as int,
      reportId: map['reportId'] as int,
      supportId: map['supportId'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      description: map['description'] as String,
      status: Status.values[map['status']],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportSession.fromJson(String source) => ReportSession.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportSession(reportSessionId: $reportSessionId, reportId: $reportId, supportId: $supportId, createAt: $createAt, description: $description, status: $status)';
  }

  @override
  bool operator ==(covariant ReportSession other) {
    if (identical(this, other)) return true;
  
    return 
      other.reportSessionId == reportSessionId &&
      other.reportId == reportId &&
      other.supportId == supportId &&
      other.createAt == createAt &&
      other.description == description &&
      other.status == status;
  }

  @override
  int get hashCode {
    return reportSessionId.hashCode ^
      reportId.hashCode ^
      supportId.hashCode ^
      createAt.hashCode ^
      description.hashCode ^
      status.hashCode;
  }
}
