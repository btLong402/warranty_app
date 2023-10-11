import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/employee_actions_controller.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/views/employee/report/report_session_detail.dart';

import 'package:warranty_app/views/employee/widgets/report_session_card.dart';

class ReportSessionList extends StatefulWidget {
  const ReportSessionList({super.key, required this.report});
  final Report report;
  @override
  State<ReportSessionList> createState() => _ReportSessionListState();
}

class _ReportSessionListState extends State<ReportSessionList> {
  final EmployeeActionsController employeeActionsController = Get.find();
  @override
  void initState() {
    employeeActionsController.queryRpSsOnStream(
        reportId: widget.report.reportId!);
    super.initState();
  }

  @override
  void dispose() {
    employeeActionsController.closeRpSsStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Sessions'),
        centerTitle: true,
      ),
      body: Obx(() {
        return AnimationLimiter(
          child: ListView.builder(
              scrollDirection:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal,
              itemCount: employeeActionsController.reportSessionList.length,
              itemBuilder: (BuildContext context, int index) {
                ReportSession rpSS =
                    employeeActionsController.reportSessionList[index];
                // debugPrint(rpSS.toString());

                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 500 + index * 20),
                    child: SlideAnimation(
                      horizontalOffset: 400.0,
                      child: FadeInAnimation(
                          child: GestureDetector(
                        child: ReportSessionCard(reportSession: rpSS),
                        onTap: () => Get.to(() => ReportSessionDetail(
                            reportSession: rpSS, report: widget.report)),
                      )),
                    ));
              }),
        );
      }),
    );
  }
}
