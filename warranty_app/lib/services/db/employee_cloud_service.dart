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

  Future createPlan(
      {required String taskId,
      String? itemErrorId,
      String? itemPlaceId}) async {
    String planId = const Uuid().v4();
    return await planCollection.doc(planId).set({
      "planId": planId,
      "taskId": taskId,
      "itemErrorId": itemErrorId ?? '',
      "itemPlaceId": itemPlaceId ?? '',
      "status" : 0,
    });
  }

  @override
  Future queryReport({String? reportId, int? status}) async {
    DocumentSnapshot snapshot = await reportCollection.doc(reportId).get();
    return snapshot;
  }
}
