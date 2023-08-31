import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/models/Item/item_model.dart';
import 'package:warranty_app/models/Plan/plan_model.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/models/Purchase%20History/purchase_history_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/models/Task/task_model.dart';
class BaseController extends GetxController { 
  final RxList reportList = <Report>[].obs;
  final RxList reportSessionList = <ReportSession>[].obs;
  final RxList taskList = <Task>[].obs;
  final RxList planList = <Plan>[].obs;
  Rx<PurchaseHistoryModel> purchase = PurchaseHistoryModel().obs;
  final RxList productList = <Map<String, Product>>[].obs;
  final RxList itemList = <Map<String, Item>>[].obs;
  final RxList feedback = <Feedback>[].obs;
}
