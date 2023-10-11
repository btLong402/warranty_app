import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/employee_actions_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/models/Item/item_model.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/widgets/button.dart';
import 'package:warranty_app/widgets/input_filed_custom.dart';

class CreatePlan extends StatefulWidget {
  const CreatePlan({super.key, required this.product, required this.taskId});
  final Product product;
  final String taskId;
  @override
  State<CreatePlan> createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  final EmployeeActionsController employeeActionsController = Get.find();
  final ProductController productController = Get.find();
  final TextEditingController descriptionController = TextEditingController();

  String? itemError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Plan'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Choose the item error:",
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
                    hint: const Text('Select Item',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    items: widget.product.itemList.map((item) {
                      Item it = productController.itemList[item];
                      return DropdownMenuItem<String>(
                          value: it.itemId,
                          child: Text(
                            it.name,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ));
                    }).toList(),
                    value: itemError,
                    onChanged: (String? value) {
                      setState(() {
                        itemError = value;
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
          InputField(
            label: 'Description',
            placeHolder: 'Enter Description',
            controller: descriptionController,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonWidget1(
                  label: 'Sent',
                  onTap: () {
                    employeeActionsController.createPlan(
                        taskId: widget.taskId,
                        itemErrorId: itemError,
                        description: descriptionController.text);
                    Get.back();
                  },
                  color: const Color(0xFF121212))
            ],
          )
        ]),
      ),
    );
  }
}
