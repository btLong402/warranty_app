import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/utils/constant.dart';

import 'package:warranty_app/views/customer/customer_home.dart';
import 'package:warranty_app/views/employee/employee_home.dart';
import 'package:warranty_app/views/supporter/supporter_home.dart';
import 'package:warranty_app/widgets/loading.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  HomeView({super.key});
  UserRole? userRole;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UserController userController = Get.put(UserController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUserData().whenComplete(() {
      setState(() {
        widget.userRole = userController.user.value.role;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget homeWidget;
    switch (widget.userRole) {
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
  }
}
