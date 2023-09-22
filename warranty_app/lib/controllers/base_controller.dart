import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final Rx<Plan> plan = Plan().obs;
  Rx<PurchaseHistoryModel> purchase = PurchaseHistoryModel().obs;
  final RxList feedback = <Feedback>[].obs;
  final Rx<Report> report = Report().obs;
  StreamSubscription<QuerySnapshot>? reportStreamSubscription;
  StreamSubscription<QuerySnapshot>? reportSsStreamSubscription;
  StreamSubscription<QuerySnapshot>? assignStreamSubscription;
  StreamSubscription<QuerySnapshot>? planStreamSubscription;
  
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

  void closeRpSsStream() {
    reportSsStreamSubscription?.cancel();
  }

  void closeAssStream() {
    assignStreamSubscription?.cancel();
  }

  void closePlanStream() {
    planStreamSubscription?.cancel();
  }

  void closeReportStream() {
    reportStreamSubscription?.cancel();
  }
}
