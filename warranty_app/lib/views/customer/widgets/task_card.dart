import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_app/controllers/customer_actions_controller.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/utils/constant.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});
  final Task task;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  CustomerActionsController customerActionsController = Get.find();
  UserModel creator = UserModel(), employee = UserModel();
  @override
  void initState() {
    // 
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final fetchedCreator = await customerActionsController.getUserInfo(
          userId: widget.task.creatorId);
      final fetchedEmployee = await customerActionsController.getUserInfo(
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
    DateTime now = DateTime.now();
    bool isSameDay = false;
    if (widget.task.createAt.day == now.day &&
        widget.task.createAt.month == now.month &&
        widget.task.createAt.year == now.year) isSameDay = true;
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
              Image.asset("assets/images/report.png"),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Creator: ${creator.userName}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Employee: ${employee.userName}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      "Status: ${widget.task.status.toString().split('.').last}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(ColorStatus
                              .values[widget.task.status.index].hexCode))),
                ],
              )
            ],
          ),
        ),
        trailing: Column(children: [
          Text(
            isSameDay
                ? DateFormat('h:mm a').format(widget.task.createAt)
                : DateFormat.yMMMd().format(widget.task.createAt),
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }
}
