import 'package:cloud_firestore/cloud_firestore.dart';

mixin AdvancedService {
  final CollectionReference purchaseCollection =
      FirebaseFirestore.instance.collection('purchase history');
  Future queryPurchaseHistory({String? customerId});
}
