import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/base_controller.dart';
import 'package:warranty_app/models/Plan/plan_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/services/db/employee_cloud_service.dart';

class EmployeeActionsController extends BaseController {
  final EmployeeDBService cloudService =
      EmployeeDBService(FirebaseAuth.instance.currentUser!.uid);
  final Rx<Report> report = Report().obs;
  final RxList anotherTask = <Task>[].obs;
  StreamSubscription<QuerySnapshot>? anotherTaskSubscription;
  Future<void> createPlan(
      {required String taskId,
      String? itemErrorId,
      String? description}) async {
    try {
      await cloudService
          .createPlan(
              taskId: taskId,
              itemErrorId: itemErrorId,
              description: description)
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
      QuerySnapshot snapshot = await cloudService.queryTask();
      List<Task> tasks = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Task.fromMap(map);
      }).toList();
      taskList.assignAll(tasks);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryReport({required String reportId}) async {
    try {
      DocumentSnapshot snapshot =
          await cloudService.queryReportOnce(reportId: reportId);
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

  Future<void> queryReportSession({required String reportId}) async {
    try {
      clearReportSessionList();
      QuerySnapshot snapshot =
          await cloudService.queryReportSession(reportId: reportId);
      List<ReportSession> sessions = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return ReportSession.fromMap(map);
      }).toList();
      reportSessionList.assignAll(sessions);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<void> queryPlan({required String taskId}) async {
    try {
      QuerySnapshot snapshot = await cloudService.queryPlan(taskId: taskId);
      List<Plan> plans = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Plan.fromMap(map);
      }).toList();
      planList.assignAll(plans);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  void queryAssignmentOnStream() {
    assignStreamSubscription =
        cloudService.queryAssignmentOnStream().listen((QuerySnapshot snapshot) {
      List<Task> tasks = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Task.fromMap(map);
      }).toList();
      taskList.assignAll(tasks);
    });
  }

  void queryAssignmentReceivedOnStream() {
    assignReceivedStream = cloudService
        .queryAssignmentReceivedOnStream()
        .listen((QuerySnapshot snapshot) {
      List<Task> tasks = snapshot.docs
          .map((DocumentSnapshot doc) {
            Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
            return Task.fromMap(map);
          })
          .where((task) => task.status.index > 0)
          .toList();
      taskList.assignAll(tasks);
    });
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

  void queryAnotherAssignment(
      {required String reportId, required String taskId}) {
    anotherTaskSubscription = cloudService
        .queryAnotherAssignment(reportId: reportId, taskId: taskId)
        .listen((QuerySnapshot snapshot) {
      List<Task> tasks = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        return Task.fromMap(map);
      }).toList();
      anotherTask.assignAll(tasks);
    });
  }

  Future addToProgress({required String taskId}) async {
    try {
      await cloudService.addToProgress(taskId: taskId);
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
}
