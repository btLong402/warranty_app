import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/supporter_actions_controller.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/widgets/button.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key, required this.report});
  final Report report;
  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  SupporterActionsController supporterActionsController = Get.find();
  @override
  void initState() {
    super.initState();
    supporterActionsController.queryEmployee();
  }

  String? selectedEmployeeId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create A new Task'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          //          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Choose the employee: ",
                  style: TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                      hint: const Text('Select here',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      items: supporterActionsController.listEmployee
                          .map((employee) {
                        return DropdownMenuItem<String>(
                            value: employee.userId,
                            child: Text(
                              employee.userName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ));
                      }).toList(),
                      value: selectedEmployeeId,
                      onChanged: (String? value) {
                        setState(() {
                          selectedEmployeeId = value;
                          // debugPrint(' productId: $productId');
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black26,
                              ))),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 25.0,
                        ),
                        iconSize: 14,
                      ),
                    )))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonWidget1(
                    label: 'Assign',
                    onTap: () {
                      if (selectedEmployeeId != null) {
                        supporterActionsController.createTask(
                            reportId: widget.report.reportId!,
                            employeeId: selectedEmployeeId!);
                        Get.back();
                      }
                    },
                    color: const Color(0xFF121212))
              ],
            )
          ],
        ),
      ),
    );
  }
}
