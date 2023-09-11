import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/auth_controller.dart';
import 'package:warranty_app/controllers/customer_actions_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/views/customer/create_report_screen.dart';
import 'package:warranty_app/widgets/report_card.dart';
import 'package:warranty_app/views/customer/report_detail.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  final AuthController authController = Get.find();
  final UserController userController = Get.find();
  final ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    // customerController.clearReport();

    // productController.clearAll();
    productController.getProduct();
    productController.getItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomerActionsController customerController =
        Get.put(CustomerActionsController());
    customerController.queryPurchaseHistory();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer'),
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(() {
            return DrawerHeader(
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
                    backgroundImage:
                        AssetImage("assets/images/user_profile.png"),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(userController.user.value.userName!,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 30.0)),
                ],
              ),
            );
          }),
          ElevatedButton(
              onPressed: () {
                userController.clearUserData();
                Get.delete<CustomerActionsController>();
                authController.logout();
              },
              child: const Text("Logout")),
        ],
      )),
      body: Obx(() {
        customerController.queryReport();
        return AnimationLimiter(
          child: ListView.builder(
            scrollDirection:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
            itemCount: customerController.reportList.length,
            itemBuilder: (BuildContext context, int index) {
              Report report = customerController.reportList[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 500 + index * 20),
                child: SlideAnimation(
                  horizontalOffset: 400.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () => Get.to(
                          () => ReportDetail(
                                report: report,
                              ),
                          transition: Transition.downToUp),
                      child: ReportCard(report: report),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const CreateReportScreen(),
            transition: Transition.downToUp),
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget _report() {
  //   return ;
  // }
}
