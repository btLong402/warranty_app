import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/controllers/supporter_actions_controller.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/utils/constant.dart';
import 'package:warranty_app/views/customer/assignment/assignment_screen.dart';
import 'package:warranty_app/views/supporter/report/report_session_list.dart';
import 'package:warranty_app/views/supporter/widgets/create_report_ss.dart';
import 'package:warranty_app/widgets/button.dart';

class ReportDetail extends StatefulWidget {
  const ReportDetail({super.key, required this.report});
  final Report report;
  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  final SupporterActionsController supporterActionsController = Get.find();
  UserModel customer = UserModel();
  Future<void> fetchUserInfo() async {
    try {
      final fetchedUser = await supporterActionsController.getUserInfo(
          userId: widget.report.customerId!);
      setState(() {
        customer = UserModel().copyWith(
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
  void initState() {
    // TODO: implement initState
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Product product =
        Get.find<ProductController>().productList[widget.report.productId];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Detail'),
        centerTitle: true,
        actions: widget.report.status?.index == 1
            ? [
                IconButton(
                  onPressed: () => displayBottomSheet(context, widget.report),
                  icon: const Icon(Icons.add),
                ),
              ]
            : [],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
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
                      const Text(
                        'Customer Info',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Full Name: ${customer.userName}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Contact: ${customer.email}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Phone Number: ${customer.contact}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                      const Text(
                        'Report',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Product Name: ${product.name}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 300,
                                child: Text(
                                  'Product Code: ${product.productId}',
                                  style: const TextStyle(fontSize: 16),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Description:',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                            child: Text(widget.report.description.toString(),
                                style: const TextStyle(fontSize: 16))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Status: ${widget.report.status.toString().split('.').last}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(ColorStatus
                                            .values[widget.report.status!.index]
                                            .hexCode),
                                        fontSize: 16)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Create at: ${DateFormat.yMd().add_jm().format(widget.report.createAt!)}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget2(
                label: 'Report Session',
                onTap: () =>
                    Get.to(() => ReportSessionList(report: widget.report)),
                width: 320,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget2(
                label: 'Assignment',
                onTap: () => Get.to(() => AssignmentScreen(
                      reportId: widget.report.reportId!,
                    )),
                width: 320,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonWidget1(
                      label: 'Update status',
                      onTap: () => displayBottomSheet1(context, widget.report),
                      width: 120,
                      color: Colors.blueAccent)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  displayBottomSheet(context, Report report) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return _bottomSheet(report);
        });
  }

  Widget _bottomSheet(Report report) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.2
          : MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => Get.to(
                  () => CreateReportSs(reportId: report.reportId!),
                  transition: Transition.downToUp),
              child: const Text('Create new Report Session')),
          ElevatedButton(
              onPressed: () {}, child: const Text('Create new Task')),
        ],
      ),
    );
  }

  displayBottomSheet1(context, Report report) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return _bottomSheet1(report);
        });
  }

  Widget _bottomSheet1(Report report) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.2
          : MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                await supporterActionsController.updateReportStatus(
                    reportId: widget.report.reportId!, status: 0);
                Get.back();
              },
              child: const Text('Pending')),
          ElevatedButton(
              onPressed: () async {
                await supporterActionsController.addToProgress(
                    reportId: widget.report.reportId!);
                await supporterActionsController.updateReportStatus(
                    reportId: widget.report.reportId!, status: 1);
                Get.back(closeOverlays: true);
              },
              child: const Text('Progress')),
          ElevatedButton(
              onPressed: () async {
                await supporterActionsController.updateReportStatus(
                    reportId: widget.report.reportId!, status: 2);
                Get.back(closeOverlays: true);
              },
              child: const Text('Complete')),
        ],
      ),
    );
  }
}
