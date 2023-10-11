import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_app/controllers/supporter_actions_controller.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/utils/constant.dart';
import 'package:warranty_app/views/supporter/assignment/plan_list.dart';
import 'package:warranty_app/widgets/button.dart';

class AssignmentDetail extends StatefulWidget {
  const AssignmentDetail({super.key, required this.task});
  final Task task;
  @override
  State<AssignmentDetail> createState() => _AssignmentDetailState();
}

class _AssignmentDetailState extends State<AssignmentDetail> {
  SupporterActionsController supporterActionsController = Get.find();
  UserModel creator = UserModel(), employee = UserModel();
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    // Su.queryPlanOnStream(taskId: widget.task.taskId);
  }

  Future<void> fetchUserInfo() async {
    try {
      final fetchedCreator = await supporterActionsController.getUserInfo(
          userId: widget.task.creatorId);
      final fetchedEmployee = await supporterActionsController.getUserInfo(
          userId: widget.task.employeeId);
      setState(() {
        creator = UserModel().copyWith(
            contact: fetchedCreator.contact,
            email: fetchedCreator.email,
            role: fetchedCreator.role,
            userId: fetchedCreator.userId,
            userName: fetchedCreator.userName);
        employee = UserModel().copyWith(
            contact: fetchedEmployee.contact,
            email: fetchedEmployee.email,
            role: fetchedEmployee.role,
            userId: fetchedEmployee.userId,
            userName: fetchedEmployee.userName);
      });
    } catch (e) {
      // Handle any potential errors when fetching user information
      debugPrint("Error fetching user information: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.task.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
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
                                Text('Creator: ${creator.userName}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Phone Number: ${creator.contact}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text('Employee: ${employee.userName}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Phone Number: ${employee.contact}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                    "Status: ${widget.task.status.toString().split('.').last}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(ColorStatus
                                            .values[widget.task.status.index]
                                            .hexCode),
                                        fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Create at: ${DateFormat.yMd().add_jm().format(widget.task.createAt)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ))),
          const SizedBox(
            height: 20,
          ),
          // _plan()
          ButtonWidget2(
            label: 'Plan',
            onTap: () => Get.to(() => PlanList(taskId: widget.task.taskId)),
            width: 320,
          ),
        ]),
      )),
    );
  }
}
