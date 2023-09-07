import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/models/Item/item_model.dart';
import 'package:warranty_app/services/db/product_cloud_service.dart';

class ProductController extends GetxController {
  final RxMap productList = <String, Product>{}.obs;
  final RxMap itemList = <String, Item>{}.obs;
  final ProductCloudService cloudService = ProductCloudService();
  Future<void> getProduct() async {
    try {
      QuerySnapshot snapshot = await cloudService.queryProduct();
      Map<String, Product> productMap = {};

      for (var doc in snapshot.docs) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        Product p = Product.fromMap(map);
        productMap[p.productId] = p;
      }

      productList.assignAll(productMap);
    } on FirebaseException catch (e) {
      Get.snackbar("Error with code: ${e.code}", e.message.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> getItem() async {
    try {
      QuerySnapshot snapshot = await cloudService.queryItem();
      Map<String, Item> itemMap = {};
      for (var doc in snapshot.docs) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        Item i = Item.fromMap(map);
        itemMap[i.itemId] = i;
      }
      itemList.assignAll(itemMap);
    } on FirebaseException catch (e) {
      Get.snackbar("Error with code: ${e.code}", e.message.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  // clearAll() {
  //   productList.clear();
  //   itemList.clear();
  // }
}
