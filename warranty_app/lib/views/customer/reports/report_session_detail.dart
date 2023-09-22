import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_app/controllers/customer_actions_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/utils/constant.dart';
// import 'package:warranty_app/views/customer/assignment/assignment_screen.dart';
// import 'package:warranty_app/widgets/button.dart';

class ReportSessionDetail extends StatefulWidget {
  const ReportSessionDetail(
      {super.key, required this.reportSession, required this.report});
  final ReportSession reportSession;
  final Report report;

  @override
  State<ReportSessionDetail> createState() => _ReportSessionDetailState();
}

class _ReportSessionDetailState extends State<ReportSessionDetail> {
  final CustomerActionsController customerController = Get.find();
  UserModel supporter = UserModel();

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final fetchedUser = await customerController.getUserInfo(
          userId: widget.reportSession.supportId);
      setState(() {
        supporter = UserModel().copyWith(
            contact: fetchedUser.contact,
            email: fetchedUser.email,
            role: fetchedUser.role,
            userId: fetchedUser.userId,
            userName: fetchedUser.userName);
      });
    } catch (e) {
      // Handle any potential errors when fetching user information
      debugPrint("Error fetching user information: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Product product =
        Get.find<ProductController>().productList[widget.report.productId];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Session Detail'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          Container(
              width: 320,
              margin: const EdgeInsets.only(top: 20),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF0099CD)),
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 25, top: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Supporter: ${supporter.userName}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Phone Number: ${supporter.contact}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Product Name: ${product.name}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                                width: 300,
                                child: Text(
                                  'Product Code: ${product.productId}',
                                  style: const TextStyle(fontSize: 16),
                                )),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Text(
                                  'Description:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Container(
                        width: 260,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF0099CD)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                widget.reportSession.description.toString(),
                                style: const TextStyle(fontSize: 16))),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Status: ${widget.reportSession.status.toString().split('.').last}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(ColorStatus
                                            .values[widget
                                                .reportSession.status.index]
                                            .hexCode),
                                        fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Create at: ${DateFormat.yMd().add_jm().format(widget.reportSession.createAt)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ))),
          // const SizedBox(
          //   height: 20,
          // ),
          // ButtonWidget2(
          //   label: 'Assignment',
          //   onTap: () => Get.to(() => AssignmentScreen(reportId: widget.report.reportId!)),
          //   width: 320,
          // )
        ]),
      )),
    );
  }
}
