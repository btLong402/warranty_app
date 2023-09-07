import 'package:get/get.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:warranty_app/utils/constant.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report});
  final Report report;
  @override
  Widget build(BuildContext context) {
    Product product =
        Get.find<ProductController>().productList[report.productId];
    DateTime now = DateTime.now();
    bool isSameDay = false;
    if (report.createAt!.day == now.day &&
        report.createAt!.month == now.month &&
        report.createAt!.year == now.year) isSameDay = true;
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ListTile(
        title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const CircleAvatar(
                //   radius: 30.0,
                //   backgroundImage: AssetImage("assets/images/report.png"),
                // ),
                Image.asset("assets/images/report.png"),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Report Error!",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                        width: 160.0,
                        child: Text(
                          "Product: ${product.name}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black54),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text("Status: ${report.status.toString().split('.').last}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(ColorStatus
                                .values[report.status!.index].hexCode))),
                  ],
                )
              ],
            )),
        trailing: Column(children: [
          Text(
            isSameDay
                ? DateFormat('h:mm a').format(report.createAt!)
                : DateFormat.yMMMd().format(report.createAt!),
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(
          //   height: 5.0,
          // ),
          // const Icon(Icons.report_problem_outlined)
        ]),
      ),
    );
  }
}
