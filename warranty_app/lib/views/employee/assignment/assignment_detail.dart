import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_app/controllers/employee_actions_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/models/Task/task_model.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/utils/constant.dart';
import 'package:warranty_app/views/employee/assignment/assignment_list.dart';
import 'package:warranty_app/views/employee/assignment/create_plan.dart';
import 'package:warranty_app/views/employee/assignment/plan_list.dart';
import 'package:warranty_app/views/employee/report/report_session_list.dart';
import 'package:warranty_app/widgets/button.dart';

class AssignmentDetail extends StatefulWidget {
  const AssignmentDetail({super.key, required this.task});
  final Task task;
  @override
  State<AssignmentDetail> createState() => _AssignmentDetailState();
}

class _AssignmentDetailState extends State<AssignmentDetail> {
  final EmployeeActionsController employeeActionsController = Get.find();
  UserModel creator = UserModel(), employee = UserModel();
  UserModel customer = UserModel();
  Future<void> fetchUserInfo() async {
    try {
      final fetchedCreator = await employeeActionsController.getUserInfo(
          userId: widget.task.creatorId);
      final fetchedEmployee = await employeeActionsController.getUserInfo(
          userId: widget.task.employeeId);
      final fetchedUser = await employeeActionsController.getUserInfo(
          userId: employeeActionsController.report.value.customerId!);
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
    super.initState();
    fetchUserInfo();
    employeeActionsController.queryPlanOnStream(taskId: widget.task.taskId);
    employeeActionsController.queryReport(reportId: widget.task.reportId);
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.task.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        centerTitle: true,
        actions: widget.task.status.index == 1
            ? [
                IconButton(
                  onPressed: () => displayBottomSheet(context, widget.task),
                  icon: const Icon(Icons.add),
                ),
              ]
            : [],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  width: 320,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF0099CD)),
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
                                                .values[
                                                    widget.task.status.index]
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
              _report(),
              const SizedBox(
                height: 20,
              ),
              // _plan(),
              ButtonWidget2(
                label: 'Plan',
                onTap: () => Get.to(() => PlanList(taskId: widget.task.taskId)),
                width: 320,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget2(
                label: 'Report Session',
                onTap: () => Get.to(() => ReportSessionList(
                    report: employeeActionsController.report.value)),
                width: 320,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget2(
                label: 'Another Assignment',
                onTap: () => Get.to(() => AssignmentList(
                      reportId:
                          employeeActionsController.report.value.reportId!,
                      taskId: widget.task.taskId,
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
                      onTap: () => displayBottomSheet1(context, widget.task),
                      width: 120,
                      color: Colors.blueAccent)
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _report() {
    if (employeeActionsController.report.value.productId == null) {
      return Container();
    } else {
      Product product = Get.find<ProductController>()
          .productList[employeeActionsController.report.value.productId];
      return Column(children: [
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      side:
                          const BorderSide(width: 1, color: Color(0xFF0099CD)),
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
                          employeeActionsController.report.value.description
                              .toString(),
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
                              "Status: ${employeeActionsController.report.value.status.toString().split('.').last}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(ColorStatus
                                      .values[employeeActionsController
                                          .report.value.status!.index]
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
                            'Create at: ${DateFormat.yMd().add_jm().format(employeeActionsController.report.value.createAt!)}',
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
      ]);
    }
  }

  displayBottomSheet(context, Task task) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return _bottomSheet(task);
        });
  }

  Widget _bottomSheet(Task task) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.2
          : MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => Get.to(() => CreatePlan(
                  product: Get.find<ProductController>().productList[
                      employeeActionsController.report.value.productId],
                  taskId: widget.task.taskId)),
              child: const Text('Create new Plan')),
        ],
      ),
    );
  }

  displayBottomSheet1(context, Task task) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          if (task.status == Status.pending) {
            return _bottomSheet1(task);
          } else {
            return _bottomSheet2(task);
          }
        });
  }

  Widget _bottomSheet1(Task task) {
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
                await employeeActionsController.addToProgress(
                    taskId: task.taskId);
                await employeeActionsController.updateTaskStatus(
                    taskId: task.taskId, status: 1);
                Get.back(closeOverlays: true);
              },
              child: const Text('Receive')),
        ],
      ),
    );
  }

  Widget _bottomSheet2(Task task) {
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
                await employeeActionsController.updateTaskStatus(
                    taskId: task.taskId, status: 2);
                Get.back(closeOverlays: true);
              },
              child: const Text('Completed')),
          ElevatedButton(
              onPressed: () async {
                await employeeActionsController.updateTaskStatus(
                    taskId: task.taskId, status: 3);
                Get.back(closeOverlays: true);
              },
              child: const Text('Uncompleted')),
        ],
      ),
    );
  }
}
