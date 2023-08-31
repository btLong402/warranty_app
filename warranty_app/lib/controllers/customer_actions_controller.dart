import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/base_controller.dart';
import 'package:warranty_app/models/Plan/plan_model.dart';
import 'package:warranty_app/models/Purchase%20History/purchase_history_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/models/Task/task_model.dart';

import 'package:warranty_app/services/db/customer_cloud_service.dart';

class CustomerActionsController extends BaseController {
  // final String uid = FirebaseAuth.instance.currentUser!.uid;
  final CustomerDBService cloudService =
      CustomerDBService(FirebaseAuth.instance.currentUser!.uid);
  Future<void> createReport(
      {required String productId, required String description}) async {
    try {
      await cloudService.createReport(productId, description).whenComplete(() =>
          Get.snackbar("Success", "You have created it successfully!",
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green));
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryReport() async {
    try {
      clearReportList();
      QuerySnapshot snapshot = await cloudService.queryReport();
      List<Report> reports = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Report.fromMap(data);
      }).toList();
      reportList.addAll(reports);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryReportSession({required String reportId}) async {
    try {
      clearReportSessionList();
      QuerySnapshot snapshot =
          await cloudService.queryReportSession(reportId: reportId);
      List<ReportSession> sessions = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return ReportSession.fromMap(map);
      }).toList();
      reportSessionList.addAll(sessions);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryTasks({required String reportId}) async {
    try {
      clearTaskList();
      QuerySnapshot snapshot = await cloudService.queryTask(reportId: reportId);
      List<Task> tasks = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Task.fromMap(map);
      }).toList();
      taskList.addAll(tasks);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryPurchaseHistory() async {
    try {
      clearPurchase();
      QuerySnapshot snapshot = await cloudService.queryPurchaseHistory();
      List<PurchaseHistoryModel> purchases =
          snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return PurchaseHistoryModel.fromMap(map);
      }).toList();
      purchase.value = PurchaseHistoryModel().copyWith(
          customerId: purchases[0].customerId,
          productIdList: purchases[0].productIdList);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

    Future<void> queryPlan({required String taskId}) async {
    try {
      clearPlanList();
      QuerySnapshot snapshot = await cloudService.queryPlan(taskId: taskId);
      List<Plan> plans = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Plan.fromMap(map);
      }).toList();
      planList.addAll(plans);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }
}
