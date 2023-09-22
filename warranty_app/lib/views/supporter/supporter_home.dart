import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/auth_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/controllers/supporter_actions_controller.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/views/supporter/screens/report_pending.dart';
import 'package:warranty_app/views/supporter/screens/report_progress.dart';

class SupporterHome extends StatefulWidget {
  const SupporterHome({super.key});
  @override
  State<SupporterHome> createState() => _SupporterHomeState();
}

class _SupporterHomeState extends State<SupporterHome> {
  final AuthController authController = Get.find();
  final UserController userController = Get.find();
  final ProductController productController = Get.put(ProductController());
  final SupporterActionsController supporterActionsController =
      Get.put(SupporterActionsController());
  int index = 0;
  final screens = [
    ReportPending(),
    const ReportProgress(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    productController.getProduct();
    productController.getItem();
    supporterActionsController.queryReport();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    supporterActionsController.closeReportStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supporter'),
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
                Get.delete<SupporterActionsController>()
                    .whenComplete(() => authController.logout());
              },
              child: const Text("Logout")),
        ],
      )),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.article_sharp, title: 'Processing'),
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
