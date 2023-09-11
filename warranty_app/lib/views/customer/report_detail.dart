import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/utils/constant.dart';
import 'package:warranty_app/widgets/button.dart';

class ReportDetail extends StatefulWidget {
  const ReportDetail({super.key, required this.report});
  final Report report;
  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    Product product =
        Get.find<ProductController>().productList[widget.report.productId];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Detail'),
        centerTitle: true,
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
                        child: Obx(() {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Full Name: ${userController.user.value.userName}',
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
                                    'Contact: ${userController.user.value.email}',
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
                                    'Phone Number: ${userController.user.value.contact}',
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }),
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
                onTap: () {},
                width: 320,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget2(
                label: 'Assignment',
                onTap: () {},
                width: 320,
              )
            ],
          ),
        ),
      ),
    );
  }
}
