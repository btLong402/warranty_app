import 'package:get/get.dart';
import 'package:warranty_app/controllers/auth_controller.dart';
import 'package:warranty_app/controllers/user_controller.dart';

Future<void> init() async {
  Get.put(AuthController());
  Get.put(UserController());
}
