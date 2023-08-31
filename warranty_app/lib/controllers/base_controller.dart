import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/models/Plan/plan_model.dart';
import 'package:warranty_app/models/Purchase%20History/purchase_history_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/models/Task/task_model.dart';

abstract class BaseController extends GetxController {
  final RxList reportList = <Report>[].obs;
  final RxList reportSessionList = <ReportSession>[].obs;
  final RxList taskList = <Task>[].obs;
  final RxList planList = <Plan>[].obs;
  Rx<PurchaseHistoryModel> purchase = PurchaseHistoryModel().obs;
  final RxList feedback = <Feedback>[].obs;
  final Rx<Report> report = Report().obs;

  void clearReportList() {
    reportList.clear();
  }

  void clearReportSessionList() {
    reportSessionList.clear();
  }

  void clearTaskList() {
    taskList.clear();
  }

  void clearPlanList() {
    planList.clear();
  }

  void clearPurchase() {
    purchase.value = PurchaseHistoryModel();
  }

  void clearReport() {
    report.value = Report();
  }

  void clearAll() {
    clearPlanList();
    clearPurchase();
    clearReport();
    clearReportList();
    clearReportSessionList();
    clearTaskList();
  }
}
