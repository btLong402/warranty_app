import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/employee_actions_controller.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/views/employee/assignment/assignment_card.dart';
import 'package:warranty_app/views/employee/assignment/assignment_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final EmployeeActionsController employeeActionsController = Get.find();
  @override
  void initState() {
    super.initState();
    employeeActionsController.queryAssignmentOnStream();
  }

  @override
  void dispose() {
    super.dispose();
    employeeActionsController.closeAssStream();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimationLimiter(
        child: ListView.builder(
          scrollDirection:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal,
          itemCount: employeeActionsController.taskList.length,
          itemBuilder: (BuildContext context, int index) {
            Task task = employeeActionsController.taskList[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 500 + index * 20),
              child: SlideAnimation(
                horizontalOffset: 400.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () => Get.to(() => AssignmentDetail(task: task),
                        transition: Transition.downToUp),
                    child: AssignmentCard(task: task),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
