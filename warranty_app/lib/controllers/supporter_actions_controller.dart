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
import 'package:warranty_app/models/User/user_model.dart';
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
      int status0 = status ?? 0;
      reportStreamSubscription = cloudService
          .queryReport(status: status0)
          .listen((QuerySnapshot snapshot) {
        List<Report> reports = snapshot.docs.map((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Report.fromMap(data);
        }).toList();
        reportList.assignAll(reports);
      });
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

  Future<void> queryTask({required String reportId}) async {
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

  Future<void> queryPurchaseHistory({required String customerId}) async {
    try {
      clearPurchase();
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

  Future<void> updatePlanStatus(
      {required String planId, required int status}) async {
    try {
      await cloudService
          .updatePlanStatus(planId: planId, status: status)
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

  Future<void> updateReportStatus(
      {required String reportId, required int status}) async {
    try {
      await cloudService
          .updateReportStatus(reportId: reportId, status: status)
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

  Future<void> updateReportSessionStatus(
      {required String reportSessionId, required int status}) async {
    try {
      await cloudService
          .updateSessionStatus(reportSSId: reportSessionId, status: status)
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

  Future<void> updateTaskStatus(
      {required String taskId, required int status}) async {
    try {
      await cloudService
          .updateTaskStatus(taskId: taskId, status: status)
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

  Future<UserModel> getUserInfo({required String userId}) async {
    UserModel user = UserModel();
    try {
      DocumentSnapshot snapshot = await cloudService.queryUser(uid: userId);
      if (snapshot.exists) {
        user = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error with code: ${e.code}", e.message.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
    return user;
  }

  Future addToProgress({required String reportId}) async {
    try {
      await cloudService.addToProgress(reportId: reportId);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  void queryRpSsOnStream({required String reportId}) {
    reportSsStreamSubscription = cloudService
        .queryReportSessionOnStream(reportId: reportId)
        .listen((QuerySnapshot snapshot) {
      List<ReportSession> sessions = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return ReportSession.fromMap(map);
      }).toList();
      reportSessionList.assignAll(sessions);
    });
  }

  void queryAssignmentOnStream({required String reportId}) {
    assignStreamSubscription = cloudService
        .queryAssignmentOnStream(reportId: reportId)
        .listen((QuerySnapshot snapshot) {
      List<Task> tasks = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Task.fromMap(map);
      }).toList();
      taskList.assignAll(tasks);
    });
  }

  void queryPlanOnStream({required String taskId}) {
    planStreamSubscription = cloudService
        .queryPlanOnStream(taskId: taskId)
        .listen((QuerySnapshot snapshot) {
      List<Plan> plans = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Plan.fromMap(map);
      }).toList();
      planList.assignAll(plans);
    });
  }
}
