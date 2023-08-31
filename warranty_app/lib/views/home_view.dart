import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/utils/constant.dart';

import 'package:warranty_app/views/customer/customer_home.dart';
import 'package:warranty_app/views/employee/employee_home.dart';
import 'package:warranty_app/views/supporter/supporter_home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UserController userController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _home();
  }

  Future<void> setUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await userController.getUserData();
  }

  Widget _home() {
    return Obx(() {
      switch (userController.user.value.role) {
        case UserRole.employee:
          return const EmployeeHome();
        case UserRole.supporter:
          return const SupporterHome();
        default:
          return const CustomerHome();
      }
    });
  }
}
