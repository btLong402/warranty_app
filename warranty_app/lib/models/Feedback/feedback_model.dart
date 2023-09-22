// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Feedback {
  final String feedbackId;
  final String reportId;
  final String customerId;
  final String toUserId;
  final String feedback;
  final DateTime createAt;
  Feedback({
    required this.feedbackId,
    required this.reportId,
    required this.customerId,
    required this.toUserId,
    required this.feedback,
    required this.createAt,
  });
  

  Feedback copyWith({
    String? feedbackId,
    String? reportId,
    String? customerId,
    String? toUserId,
    String? feedback,
    DateTime? createAt,
  }) {
    return Feedback(
      feedbackId: feedbackId ?? this.feedbackId,
      reportId: reportId ?? this.reportId,
      customerId: customerId ?? this.customerId,
      toUserId: toUserId ?? this.toUserId,
      feedback: feedback ?? this.feedback,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'feedbackId': feedbackId,
      'reportId': reportId,
      'customerId': customerId,
      'toUserId': toUserId,
      'feedback': feedback,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      feedbackId: map['feedbackId'] as String,
      reportId: map['reportId'] as String,
      customerId: map['customerId'] as String,
      toUserId: map['toUserId'] as String,
      feedback: map['feedback'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) => Feedback.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Feedback(feedbackId: $feedbackId, reportId: $reportId, customerId: $customerId, toUserId: $toUserId, feedback: $feedback, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant Feedback other) {
    if (identical(this, other)) return true;
  
    return 
      other.feedbackId == feedbackId &&
      other.reportId == reportId &&
      other.customerId == customerId &&
      other.toUserId == toUserId &&
      other.feedback == feedback &&
      other.createAt == createAt;
  }

  @override
  int get hashCode {
    return feedbackId.hashCode ^
      reportId.hashCode ^
      customerId.hashCode ^
      toUserId.hashCode ^
      feedback.hashCode ^
      createAt.hashCode;
  }
}
