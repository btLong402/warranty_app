// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/supporter_actions_controller.dart';

import 'package:warranty_app/widgets/button.dart';
import 'package:warranty_app/widgets/input_filed_custom.dart';

class CreateReportSs extends StatefulWidget {
  const CreateReportSs({
    Key? key,
    required this.reportId,
  }) : super(key: key);
  final String reportId;
  @override
  State<CreateReportSs> createState() => _CreateReportSsState();
}

class _CreateReportSsState extends State<CreateReportSs> {
  final TextEditingController descriptionController = TextEditingController();
  final SupporterActionsController supporterActionsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create A New Report Session'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
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
                    label: 'Create',
                    onTap: () {
                      if(descriptionController.text.isNotEmpty) {
                        
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
