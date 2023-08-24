// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:warranty_app/utils/status.dart';

class Task {
  final int taskId;
  final int reportId;
  final String employeeId;
  final String creatorId;
  final DateTime createAt;

  Status status;
  Task({
    required this.taskId,
    required this.reportId,
    required this.employeeId,
    required this.creatorId,
    required this.createAt,
    required this.status,
  });

  Task copyWith({
    int? taskId,
    int? reportId,
    String? employeeId,
    String? creatorId,
    DateTime? createAt,
    Status? status,
  }) {
    return Task(
      taskId: taskId ?? this.taskId,
      reportId: reportId ?? this.reportId,
      employeeId: employeeId ?? this.employeeId,
      creatorId: creatorId ?? this.creatorId,
      createAt: createAt ?? this.createAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'reportId': reportId,
      'employeeId': employeeId,
      'creatorId': creatorId,
      'createAt': createAt.millisecondsSinceEpoch,
      'status': status.index,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['taskId'] as int,
      reportId: map['reportId'] as int,
      employeeId: map['employeeId'] as String,
      creatorId: map['creatorId'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      status: Status.values[map['status']],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(taskId: $taskId, reportId: $reportId, employeeId: $employeeId, creatorId: $creatorId, createAt: $createAt, status: $status)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.taskId == taskId &&
      other.reportId == reportId &&
      other.employeeId == employeeId &&
      other.creatorId == creatorId &&
      other.createAt == createAt &&
      other.status == status;
  }

  @override
  int get hashCode {
    return taskId.hashCode ^
      reportId.hashCode ^
      employeeId.hashCode ^
      creatorId.hashCode ^
      createAt.hashCode ^
      status.hashCode;
  }
}
