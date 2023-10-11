import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/employee_actions_controller.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/views/employee/assignment/another_assignment_detail.dart';
import 'package:warranty_app/views/employee/assignment/assignment_card.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList(
      {super.key, required this.reportId, required this.taskId});
  final String reportId;
  final String taskId;
  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  final EmployeeActionsController employeeActionsController = Get.find();
  @override
  void initState() {
    super.initState();
    employeeActionsController.queryAnotherAssignment(
        reportId: widget.reportId, taskId: widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Assignment'),
        centerTitle: true,
      ),
      body: Obx(() {
        return AnimationLimiter(
          child: ListView.builder(
            scrollDirection:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
            itemCount: employeeActionsController.anotherTask.length,
            itemBuilder: (BuildContext context, int index) {
              Task task = employeeActionsController.anotherTask[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 500 + index * 20),
                child: SlideAnimation(
                  horizontalOffset: 400.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () =>
                          Get.to(() => AnotherAssignmentDetail(task: task)),
                      child: AssignmentCard(task: task),
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
