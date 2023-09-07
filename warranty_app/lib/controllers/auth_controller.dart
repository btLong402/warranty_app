import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:warranty_app/services/auth/auth_service.dart';
import 'package:warranty_app/views/auth/sign_in_screen.dart';
import 'package:warranty_app/views/home_view.dart';

class AuthController extends GetxController {
  late Rx<User?> user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.userChanges());
    ever(user, _initialScreen);
  }

  register(String email, String password, String fullName,
      String phoneNumber) async {
    return await AuthService()
        .register(email.trim(), password.trim(), phoneNumber, fullName);
  }

  login(String email, String password) async {
    // ignore: void_checks
    return await AuthService().login(email.trim(), password.trim());
  }

  void logout() async {
    await _auth.signOut();
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SignIn());
    } else {
      Get.offAll(() => const HomeView());
    }
  }
}
