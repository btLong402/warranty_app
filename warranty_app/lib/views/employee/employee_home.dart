import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/auth_controller.dart';
import 'package:warranty_app/controllers/employee_actions_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/views/employee/screens/home.dart';
import 'package:warranty_app/views/employee/screens/task_received.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({super.key});

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  final AuthController authController = Get.find();
  final UserController userController = Get.find();
  final ProductController productController = Get.put(ProductController());
  final EmployeeActionsController employeeActionsController =
      Get.put(EmployeeActionsController());
  int index = 0;
  final screens = [
    const Home(),
    const TaskReceived(),
  ];
  @override
  void initState() {
    productController.getProduct();
    productController.getItem();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee'),
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage("assets/images/user_profile.png"),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(userController.user.value.userName!,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 30.0)),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Get.delete<EmployeeActionsController>()
                    .whenComplete(() => authController.logout());
              },
              child: const Text("Logout")),
        ],
      )),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.article_sharp, title: 'Received'),
        ],
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
      ),
      body: screens[index],
    );
  }
}
