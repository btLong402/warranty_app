import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/base_controller.dart';
import 'package:warranty_app/models/Plan/plan_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/services/db/employee_cloud_service.dart';

class EmployeeActionsController extends BaseController {
  final EmployeeDBService cloudService =
      EmployeeDBService(FirebaseAuth.instance.currentUser!.uid);
  Future<void> createPlan({required String taskId, String? itemErrorId}) async {
    try {
      await cloudService
          .createPlan(taskId: taskId, itemErrorId: itemErrorId)
          .whenComplete(() => Get.snackbar(
              "Success", "You have updated it successfully!",
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

  Future<void> queryTask() async {
    try {
      clearTaskList();
      QuerySnapshot snapshot = await cloudService.queryTask();
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

  Future<void> queryReport({required String reportId}) async {
    try {
      clearReport();
      DocumentSnapshot snapshot =
          await cloudService.queryReport(reportId: reportId);
      if (snapshot.exists) {
        Report rp = Report.fromMap(snapshot.data() as Map<String, dynamic>);
        report.value = Report().copyWith(
            reportId: rp.reportId,
            productId: rp.productId,
            customerId: rp.customerId,
            createAt: rp.createAt,
            description: rp.description,
            status: rp.status);
      }
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
