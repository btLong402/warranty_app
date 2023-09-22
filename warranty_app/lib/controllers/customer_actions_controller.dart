import 'dart:async';

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

import 'package:warranty_app/services/db/customer_cloud_service.dart';

class CustomerActionsController extends BaseController {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  
  @override
  void onReady() {
    super.onReady();
    if (FirebaseAuth.instance.currentUser != null) {
      query();
    }
  }

  @override
  void onClose() {
    super.onClose();
    reportStreamSubscription?.cancel();
  }

  Future<void> createReport(
      {required String productId, required String description}) async {
    try {
      await CustomerDBService(uid)
          .createReport(productId, description)
          .whenComplete(() => Get.snackbar(
              "Success", "You have created it successfully!",
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green));
    } catch (e) {
      Get.snackbar("Error ", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryReportSession({required String reportId}) async {
    try {
      // clearReportSessionList();
      QuerySnapshot snapshot =
          await CustomerDBService(uid).queryReportSession(reportId: reportId);
      List<ReportSession> sessions = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return ReportSession.fromMap(map);
      }).toList();
      reportSessionList.assignAll(sessions);
    } on FirebaseException catch (e) {
      Get.snackbar("Error with code: ${e.code}", e.message.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryTasks({required String reportId}) async {
    try {
      // clearTaskList();
      QuerySnapshot snapshot =
          await CustomerDBService(uid).queryTask(reportId: reportId);
      List<Task> tasks = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Task.fromMap(map);
      }).toList();
      taskList.assignAll(tasks);
    } on FirebaseException catch (e) {
      Get.snackbar("Error with code: ${e.code}", e.message.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryPurchaseHistory() async {
    try {
      // clearPurchase();
      DocumentSnapshot snapshot =
          await CustomerDBService(uid).queryPurchaseHistory();
      if (snapshot.exists) {
        PurchaseHistoryModel data = PurchaseHistoryModel.fromMap(
            snapshot.data() as Map<String, dynamic>);
        purchase.value = PurchaseHistoryModel().copyWith(
            customerId: data.customerId, productIdList: data.productIdList);
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error with code: ${e.code}", e.message.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryPlan({required String taskId}) async {
    try {
      clearPlanList();
      QuerySnapshot snapshot =
          await CustomerDBService(uid).queryPlan(taskId: taskId);
      List<Plan> plans = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Plan.fromMap(map);
      }).toList();
      planList.assignAll(plans);
    } on FirebaseException catch (e) {
      Get.snackbar("Error with code: ${e.code}", e.message.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<UserModel> getUserInfo({required String userId}) async {
    UserModel user = UserModel();
    try {
      DocumentSnapshot snapshot =
          await CustomerDBService(uid).queryUser(uid: userId);
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

  void query() {
    reportStreamSubscription =
        CustomerDBService(FirebaseAuth.instance.currentUser!.uid)
            .queryReportStream()
            .listen((QuerySnapshot snapshot) {
      List<Report> reports = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Report.fromMap(data);
      }).toList();

      // Update the reportList with the new data
      reportList.assignAll(reports);
    });
  }

  void queryRpSsOnStream({required String reportId}) {
    reportSsStreamSubscription =
        CustomerDBService(FirebaseAuth.instance.currentUser!.uid)
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
    assignStreamSubscription =
        CustomerDBService(FirebaseAuth.instance.currentUser!.uid)
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
    planStreamSubscription =
        CustomerDBService(FirebaseAuth.instance.currentUser!.uid)
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
