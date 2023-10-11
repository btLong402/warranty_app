import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/customer_actions_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/models/Item/item_model.dart';
import 'package:warranty_app/utils/constant.dart';

class PlanList extends StatefulWidget {
  const PlanList({super.key, required this.taskId});
  final String taskId;
  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  final CustomerActionsController customerActionsController = Get.find();
  @override
  void initState() {
    super.initState();
    customerActionsController.queryPlanOnStream(taskId: widget.taskId);
  }

  @override
  void dispose() {
    super.dispose();
    customerActionsController.closePlanStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan'),
        centerTitle: true,
      ),
      body: Obx(() {
        return AnimationLimiter(
            child: ListView.builder(
                scrollDirection:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                itemCount: customerActionsController.planList.length,
                itemBuilder: (BuildContext context, index) {
                  Item itemErr = Get.find<ProductController>().itemList[
                      customerActionsController.planList[index].itemErrorId];
                  return Column(children: [
                    const SizedBox(height: 10),
                    Container(
                        width: 320,
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
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 25, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Item Error: ${itemErr.name}',
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Row(
                                        children: [
                                          Text(
                                            'Description of Plan:',
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
                                          customerActionsController
                                              .planList[index].description
                                              .toString(),
                                          style:
                                              const TextStyle(fontSize: 16))),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 25, top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                          "Status: ${customerActionsController.planList[index].status.toString().split('.').last}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(ColorStatus
                                                  .values[
                                                      customerActionsController
                                                          .planList[index]
                                                          .status!
                                                          .index]
                                                  .hexCode),
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )))
                  ]);
                }));
      }),
    );
  }
}
