// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:warranty_app/utils/constant.dart';

class Plan {
  final int planId;
  final int taskId;
  String? itemErrorId;
  String? itemPlaceId;
  Status status;
  Plan({
    required this.planId,
    required this.taskId,
    this.itemErrorId,
    this.itemPlaceId,
    required this.status,
  });
  

  Plan copyWith({
    int? planId,
    int? taskId,
    String? itemErrorId,
    String? itemPlaceId,
    Status? status,
  }) {
    return Plan(
      planId: planId ?? this.planId,
      taskId: taskId ?? this.taskId,
      itemErrorId: itemErrorId ?? this.itemErrorId,
      itemPlaceId: itemPlaceId ?? this.itemPlaceId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planId': planId,
      'taskId': taskId,
      'itemErrorId': itemErrorId,
      'itemPlaceId': itemPlaceId,
      'status': status.index,
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      planId: map['planId'] as int,
      taskId: map['taskId'] as int,
      itemErrorId: map['itemErrorId'] != null ? map['itemErrorId'] as String : null,
      itemPlaceId: map['itemPlaceId'] != null ? map['itemPlaceId'] as String : null,
      status: Status.values[map['status']],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plan(planId: $planId, taskId: $taskId, itemErrorId: $itemErrorId, itemPlaceId: $itemPlaceId, status: $status)';
  }

  @override
  bool operator ==(covariant Plan other) {
    if (identical(this, other)) return true;
  
    return 
      other.planId == planId &&
      other.taskId == taskId &&
      other.itemErrorId == itemErrorId &&
      other.itemPlaceId == itemPlaceId &&
      other.status == status;
  }

  @override
  int get hashCode {
    return planId.hashCode ^
      taskId.hashCode ^
      itemErrorId.hashCode ^
      itemPlaceId.hashCode ^
      status.hashCode;
  }
}
