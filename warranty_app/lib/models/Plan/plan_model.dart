// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:warranty_app/utils/constant.dart';

class Plan {
  final String? planId;
  final String? taskId;
  final String? itemErrorId;
  final String? description;
  Status? status;
  Plan({
    this.planId,
    this.taskId,
    this.itemErrorId,
    this.status,
    this.description,
  });

  Plan copyWith({
    String? planId,
    String? taskId,
    String? itemErrorId,
    Status? status,
    String? description,
  }) {
    return Plan(
      planId: planId ?? this.planId,
      taskId: taskId ?? this.taskId,
      itemErrorId: itemErrorId ?? this.itemErrorId,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planId': planId,
      'taskId': taskId,
      'itemErrorId': itemErrorId,
      'status': status!.index,
      'description': description,
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      planId: map['planId'] as String,
      taskId: map['taskId'] as String,
      itemErrorId: map['itemErrorId'] as String,
      status: Status.values[map['status']],
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) =>
      Plan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plan(planId: $planId, taskId: $taskId, itemErrorId: $itemErrorId, status: $status)';
  }

  @override
  bool operator ==(covariant Plan other) {
    if (identical(this, other)) return true;

    return other.planId == planId &&
        other.taskId == taskId &&
        other.itemErrorId == itemErrorId &&
        other.status == status &&
        other.description == description;
  }

  @override
  int get hashCode {
    return planId.hashCode ^
        taskId.hashCode ^
        itemErrorId.hashCode ^
        status.hashCode ^
        description.hashCode;
  }
}
