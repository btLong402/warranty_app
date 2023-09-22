import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:warranty_app/services/db/advanced_service.dart';
import 'package:warranty_app/services/db/base_service.dart';

class SupporterDBService extends BaseService with AdvancedService {
  SupporterDBService(super.uid);
  final CollectionReference supportProgressRef =
      FirebaseFirestore.instance.collection('Progress');
  Future createSession(String reportId, String description) async {
    String reportSSId = const Uuid().v4();
    return await reportSessionCollection.doc(reportSSId).set({
      "reportSessionId": reportSSId,
      "reportId": reportId,
      "supportId": uid,
      "description": description,
      "createAt": DateTime.now().millisecondsSinceEpoch,
      "status": 0,
    });
  }

  @override
  Stream<QuerySnapshot> queryReport({String? reportId, int? status}) {
    return reportCollection
        .where('status', isEqualTo: status)
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  Future createTask(String employeeId, String reportId) async {
    String taskId = const Uuid().v4();
    return await taskCollection.doc(taskId).set({
      "taskId": taskId,
      "reportId": reportId,
      "employeeId": employeeId,
      "creatorId": uid,
      "createAt": DateTime.now().millisecondsSinceEpoch,
      "status": 0,
    });
  }

  @override
  Future queryPurchaseHistory({String? customerId}) async {
    DocumentSnapshot snapshot = await purchaseCollection.doc(customerId).get();
    return snapshot;
  }

  Future updatePlanStatus({required String planId, required int status}) async {
    await planCollection.doc(planId).set({
      "status": status,
    });
  }

  Future updateReportStatus(
      {required String reportId, required int status}) async {
    await reportCollection.doc(reportId).update({
      'status': status,
    });
  }

  Future updateSessionStatus(
      {required String reportSSId, required int status}) async {
    await reportSessionCollection.doc(reportSSId).update({
      'status': status,
    });
  }

  Future updateTaskStatus({required String taskId, required int status}) async {
    await taskCollection.doc(taskId).update({
      'status': status,
    });
  }

  Future addToProgress({required String reportId}) async {
    await supportProgressRef.doc(uid).set({
      'listReport': FieldValue.arrayUnion([reportId]),
    }, SetOptions(merge: true));
  }
}
