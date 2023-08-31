
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCloudService {
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');
  final CollectionReference itemCollection = FirebaseFirestore.instance.collection('items');

  Future queryItem() async {
    QuerySnapshot snapshot = await itemCollection.get();
    return snapshot;
  }

  Future queryProduct() async {
    QuerySnapshot snapshot = await productCollection.get();
    return snapshot;
  }
}