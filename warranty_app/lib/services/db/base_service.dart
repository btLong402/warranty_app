import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseService {
  final String uid;
  BaseService(this.uid);

  final CollectionReference reportSessionCollection =
      FirebaseFirestore.instance.collection("reportSession");
  final CollectionReference reportCollection =
      FirebaseFirestore.instance.collection("report table");
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection("assignments");
  final CollectionReference planCollection =
      FirebaseFirestore.instance.collection('plan table');
  final CollectionReference purchaseHistoryCollection =
      FirebaseFirestore.instance.collection("purchase history table");

  Future queryReport({String? reportId, int? status});
  Future queryTask({String? reportId}) async {
    QuerySnapshot snapshot =
        await taskCollection.where('reportId', isEqualTo: reportId).get();
    return snapshot;
  }

  Future queryReportSession({required String reportId}) async {
    QuerySnapshot snapshot = await reportSessionCollection
        .where('reportId', isEqualTo: reportId)
        .get();
    return snapshot;
  }

  Future queryPlan({required String taskId}) async {
    QuerySnapshot snapshot =
        await planCollection.where('taskId', isEqualTo: taskId).get();
    return snapshot;
  }
}
