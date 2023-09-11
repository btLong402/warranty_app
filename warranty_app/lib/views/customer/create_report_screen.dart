import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/customer_actions_controller.dart';
import 'package:warranty_app/controllers/product_controller.dart';
import 'package:warranty_app/models/Product/product_model.dart';
import 'package:warranty_app/widgets/button.dart';
import 'package:warranty_app/widgets/input_filed_custom.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final CustomerActionsController customerActionsController = Get.find();
  final ProductController productController = Get.find();
  final TextEditingController descriptionController = TextEditingController();
  String? productId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create A New Report'),
          centerTitle: true,
        ),
        body: SafeArea(child: Obx(() {
          return Container(
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              //          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Choose your device: ",
                      style: TextStyle(
                          color: Color(0xFF121212),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                      hint: const Text('Select Item',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      items: customerActionsController
                          .purchase.value.productIdList!
                          .map((item) {
                        Product product = productController.productList[item];
                        return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ));
                      }).toList(),
                      value: productId,
                      onChanged: (String? value) {
                        setState(() {
                          productId = value;
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
                    ))
                  ],
                ),
                const SizedBox(
                  height: 25,
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
                          if (productId != null) {
                            customerActionsController.createReport(
                                productId: productId.toString(),
                                description: descriptionController.text);
                            Get.back();
                          }
                        },
                        color: const Color(0xFF121212))
                  ],
                )
              ],
            ),
          );
        })));
  }
}
