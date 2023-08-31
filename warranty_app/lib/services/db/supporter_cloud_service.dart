import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:warranty_app/services/db/advanced_service.dart';
import 'package:warranty_app/services/db/base_service.dart';

class SupporterDBService extends BaseService with AdvancedService {
  SupporterDBService(super.uid);

  Future createSession(String reportId, String description) async {
    String reportSSId = const Uuid().v4();
    return await reportSessionCollection
        .doc(reportSSId)
        .set({
      "reportSessionId": reportSSId,
      "reportId": reportId,
      "supportId": uid,
      "description": description,
      "createAt": DateTime.now(),
      "status": 0,
    });
  }

  @override
  Future queryReport({String? reportId, int? status}) async {
    QuerySnapshot snapshot =
        await reportCollection.where('status', isEqualTo: status).get();
    return snapshot;
  }

  Future createTask(String employeeId, String reportId) async {
    String taskId = const Uuid().v4();
    return await taskCollection
        .doc(taskId)
        .set({
      "taskId": taskId,
      "reportId": reportId,
      "employeeId": employeeId,
      "creatorId": uid,
      "createAt": DateTime.now(),
      "status": 0,
    });
  }

  @override
  Future queryPurchaseHistory({String? customerId}) async {
    DocumentSnapshot snapshot = await purchaseCollection.doc(customerId).get();
    return snapshot;
  }
}
