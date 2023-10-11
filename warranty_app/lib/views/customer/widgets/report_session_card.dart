import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_app/controllers/customer_actions_controller.dart';
import 'package:warranty_app/models/Report/report_session_model.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/utils/constant.dart';

class ReportSessionCard extends StatefulWidget {
  const ReportSessionCard({super.key, required this.reportSession});
  final ReportSession reportSession;
  @override
  State<ReportSessionCard> createState() => _ReportSessionCardState();
}

class _ReportSessionCardState extends State<ReportSessionCard> {
  final CustomerActionsController customerController = Get.find();
  UserModel user = UserModel();
  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  Future<void> fetchUserInfo() async {
    try {
      final fetchedUser = await customerController.getUserInfo(
          userId: widget.reportSession.supportId);
      setState(() {
        user = UserModel().copyWith(
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
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool isSameDay = false;
    if (widget.reportSession.createAt.day == now.day &&
        widget.reportSession.createAt.month == now.month &&
        widget.reportSession.createAt.year == now.year) isSameDay = true;

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
                  const Text(
                    "Report Session",
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Supporter: ${user.userName}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      "Status: ${widget.reportSession.status.toString().split('.').last}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(ColorStatus
                              .values[widget.reportSession.status.index]
                              .hexCode))),
                ],
              )
            ],
          ),
        ),
        trailing: Column(children: [
          Text(
            isSameDay
                ? DateFormat('h:mm a').format(widget.reportSession.createAt)
                : DateFormat.yMMMd().format(widget.reportSession.createAt),
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
