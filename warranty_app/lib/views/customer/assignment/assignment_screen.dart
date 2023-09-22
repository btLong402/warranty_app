import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/customer_actions_controller.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/views/customer/assignment/assignment_detail.dart';
import 'package:warranty_app/widgets/task_card.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key, required this.reportId});
  final String reportId;
  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  final CustomerActionsController customerActionsController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    debugPrint('widget.reportId: ${widget.reportId}');
    customerActionsController.queryAssignmentOnStream(
        reportId: widget.reportId);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customerActionsController.closeAssStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
        centerTitle: true,
      ),
      body: Obx(() {
        return AnimationLimiter(
          child: ListView.builder(
            scrollDirection:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
            itemCount: customerActionsController.taskList.length,
            itemBuilder: (BuildContext context, int index) {
              Task task = customerActionsController.taskList[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 500 + index * 20),
                child: SlideAnimation(
                  horizontalOffset: 400.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () => Get.to(() => AssignmentDetail(task: task)),
                      child: TaskCard(task: task),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
