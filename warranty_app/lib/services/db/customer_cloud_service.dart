import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:warranty_app/services/db/advanced_service.dart';
import 'package:warranty_app/services/db/base_service.dart';

class CustomerDBService extends BaseService with AdvancedService {
  CustomerDBService(super.uid);
  Future createReport(String productId, String description) async {
    String reportId = const Uuid().v4();
    return await reportCollection.doc(reportId).set({
      "reportId": reportId,
      "customerId": uid,
      "productId": productId,
      "createAt": DateTime.now(),
      "status": 0,
      "description": description
    });
  }

  @override
  Future queryReport({String? reportId, int? status}) async {
    QuerySnapshot snapshot =
        await reportCollection.where('customerId', isEqualTo: uid).get();
    return snapshot;
  }

  @override
  Future queryPurchaseHistory({String? customerId}) async {
    DocumentSnapshot snapshot = await purchaseCollection.doc(uid).get();
    return snapshot;
  }

}
