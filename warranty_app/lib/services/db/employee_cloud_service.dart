import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:warranty_app/services/db/base_service.dart';

class EmployeeDBService extends BaseService {
  EmployeeDBService(super.uid);
  final CollectionReference progressRef =
      FirebaseFirestore.instance.collection('Progress');
  @override
  Future queryTask({String? reportId}) async {
    QuerySnapshot snapshot =
        await taskCollection.where('employeeId', isEqualTo: uid).get();
    return snapshot;
  }

  Future createPlan(
      {required String taskId,
      String? itemErrorId,
      String? description}) async {
    String planId = const Uuid().v4();
    return await planCollection.doc(planId).set({
      "planId": planId,
      "taskId": taskId,
      "itemErrorId": itemErrorId ?? '',
      "description": description ?? '',
      "status": 0,
    });
  }

  @override
  Stream<QuerySnapshot<Object?>> queryReportOnStream(
      {String? reportId, int? status}) {
    throw UnimplementedError();
  }

  Future queryReportOnce({required String reportId}) async {
    DocumentSnapshot snapshot = await reportCollection.doc(reportId).get();
    return snapshot;
  }

  @override
  Stream<QuerySnapshot> queryAssignmentOnStream({String? reportId}) {
    return taskCollection
        .where('employeeId', isEqualTo: uid)
        .where('status', isEqualTo: 0)
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> queryAssignmentReceivedOnStream() {
    return taskCollection
        .where('employeeId', isEqualTo: uid)
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  Future queryReport({required String reportId}) async {
    DocumentSnapshot snapshot = await reportCollection.doc(reportId).get();
    return snapshot;
  }

  Stream<QuerySnapshot> queryAnotherAssignment(
      {required String reportId, required String taskId}) {
    return taskCollection
        .where('reportId', isEqualTo: reportId)
        .where('taskId', isNotEqualTo: taskId)
        .snapshots();
  }

  Future addToProgress({required String taskId}) async {
    await taskCollection.doc(taskId).update({
      'status': 1,
    });
  }

  Future updateTaskStatus({required String taskId, required int status}) async {
    await taskCollection.doc(taskId).update({
      'status': status,
    });
  }
}
