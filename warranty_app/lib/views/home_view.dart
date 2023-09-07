import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/utils/constant.dart';

import 'package:warranty_app/views/customer/customer_home.dart';
import 'package:warranty_app/views/employee/employee_home.dart';
import 'package:warranty_app/views/supporter/supporter_home.dart';
import 'package:warranty_app/widgets/loading.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Obx(() {
      userController.getUserData();
      final userRole = userController.user.value.role;

      Widget homeWidget;

      switch (userRole) {
        case UserRole.employee:
          homeWidget = const EmployeeHome();
          break;
        case UserRole.supporter:
          homeWidget = const SupporterHome();
          break;
        case UserRole.customer:
          homeWidget = const CustomerHome();
          break;
        default:
          homeWidget = const LoadingWidget();
          break;
      }

      return homeWidget;
    });
  }
}
