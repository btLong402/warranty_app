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
  Future <void> getProduct() async {
    try {
      QuerySnapshot snapshot = await cloudService.queryProduct();
      productList.assignAll(snapshot.docs.map((DocumentSnapshot doc){
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        Product p = Product.fromMap(map);
        Map<String, Product> ps = {p.productId : p};
        return ps;
      }) as Map);
    } catch (e) {
            Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future <void> getItem() async {
    try {
      QuerySnapshot snapshot = await cloudService.queryItem();
      itemList.assignAll(snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        Item i = Item.fromMap(map);
        Map<String, Item> it = {i.itemId: i};
        return it;
      }) as Map);
    } catch (e) {
            Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }
}
