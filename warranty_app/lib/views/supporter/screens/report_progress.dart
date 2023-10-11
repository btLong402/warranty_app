import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/supporter_actions_controller.dart';
import 'package:warranty_app/models/Report/report_model.dart';
import 'package:warranty_app/views/supporter/report/report_detail.dart';
import 'package:warranty_app/widgets/report_card.dart';

class ReportProgress extends StatefulWidget {
  const ReportProgress({super.key});

  @override
  State<ReportProgress> createState() => _ReportProgressState();
}

class _ReportProgressState extends State<ReportProgress> {
  final SupporterActionsController supporterActionsController = Get.find();
  @override
  void initState() {
    super.initState();
    supporterActionsController.queryReportProgress();
  }

  @override
  void dispose() {
    supporterActionsController.closeReportProgressStream();
    super.dispose();
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
          itemCount: supporterActionsController.reportList.length,
          itemBuilder: (BuildContext context, int index) {
            Report report = supporterActionsController.reportList[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 500 + index * 20),
              child: SlideAnimation(
                horizontalOffset: 400.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () => Get.to(
                        () => ReportDetail(
                              report: report,
                            ),
                        transition: Transition.downToUp),
                    child: ReportCard(report: report),
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
