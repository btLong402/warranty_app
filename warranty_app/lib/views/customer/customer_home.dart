import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/auth_controller.dart';
import 'package:warranty_app/controllers/user_controller.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  final AuthController authController = Get.find();
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Customer Home'),
            Text("User Name: ${userController.user.value.userName}"),
            Text("User Id: ${userController.user.value.userId}"),
            Text("Email: ${userController.user.value.email}"),
            Text("Contact: ${userController.user.value.contact}"),
            Text("User Role: ${userController.user.value.role}"),
            ElevatedButton(
                onPressed: () {
                  authController.logout();
                },
                child: const Text("Logout")),
          ],
        ),
      );
    }));
  }
}
