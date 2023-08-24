// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plan {
  final int planId;
  final int taskId;
  final int itemErrorId;
  int? itemPlaceId;
  Plan({
    required this.planId,
    required this.taskId,
    required this.itemErrorId,
    this.itemPlaceId,
  });
  

  Plan copyWith({
    int? planId,
    int? taskId,
    int? itemErrorId,
    int? itemPlaceId,
  }) {
    return Plan(
      planId: planId ?? this.planId,
      taskId: taskId ?? this.taskId,
      itemErrorId: itemErrorId ?? this.itemErrorId,
      itemPlaceId: itemPlaceId ?? this.itemPlaceId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planId': planId,
      'taskId': taskId,
      'itemErrorId': itemErrorId,
      'itemPlaceId': itemPlaceId,
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      planId: map['planId'] as int,
      taskId: map['taskId'] as int,
      itemErrorId: map['itemErrorId'] as int,
      itemPlaceId: map['itemPlaceId'] != null ? map['itemPlaceId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plan(planId: $planId, taskId: $taskId, itemErrorId: $itemErrorId, itemPlaceId: $itemPlaceId)';
  }

  @override
  bool operator ==(covariant Plan other) {
    if (identical(this, other)) return true;
  
    return 
      other.planId == planId &&
      other.taskId == taskId &&
      other.itemErrorId == itemErrorId &&
      other.itemPlaceId == itemPlaceId;
  }

  @override
  int get hashCode {
    return planId.hashCode ^
      taskId.hashCode ^
      itemErrorId.hashCode ^
      itemPlaceId.hashCode;
  }
}
