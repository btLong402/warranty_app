import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:warranty_app/services/db/base_service.dart';

class EmployeeDBService extends BaseService {
  EmployeeDBService(super.uid);
  @override
  Future queryTask({String? reportId}) async {
    QuerySnapshot snapshot =
        await taskCollection.where('employeeId', isEqualTo: uid).get();
    return snapshot;
  }

  Future createPlan({required String taskId, String? itemErrorId}) async {
    String planId = const Uuid().v4();
    return await planCollection.doc(planId).set({
      "planId": planId,
      "taskId": taskId,
      "itemErrorId": itemErrorId ?? '',
      "status": 0,
    });
  }

  @override
  Stream<QuerySnapshot> queryReport({String? reportId, int? status}) {
    return reportCollection.where('reportId', isEqualTo: reportId).snapshots();
  }

  // Stream<QueryDocumentSnapshot> queryReportStream({String reportId})
}
