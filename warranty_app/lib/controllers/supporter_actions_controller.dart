import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/base_controller.dart';
import 'package:warranty_app/models/Plan/plan_model.dart';
import 'package:warranty_app/models/Purchase%20History/purchase_history_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/services/db/supporter_cloud_service.dart';

class SupporterActionsController extends BaseController {
  final SupporterDBService cloudService =
      SupporterDBService(FirebaseAuth.instance.currentUser!.uid);

  Future<void> createSession(
      {required String reportId, required String description}) async {
    try {
      await cloudService.createSession(reportId, description).whenComplete(() =>
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

  Future<void> queryReport({int? status}) async {
    try {
      int status0 = status ?? 2;
      QuerySnapshot snapshot = await cloudService.queryReport(status: status0);
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

  Future<void> createTask(
      {required String reportId, required String employeeId}) async {
    try {
      await cloudService.createTask(employeeId, reportId).whenComplete(() =>
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

  Future<void> getTask({required String reportId}) async {
    try {
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

  Future<void> getPlan({required String taskId}) async {
    try {
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

  Future<void> getPurchaseHistory({required String customerId}) async {
    try {
      QuerySnapshot snapshot =
          await cloudService.queryPurchaseHistory(customerId: customerId);
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
}
