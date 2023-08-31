import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/user_controller.dart';
import 'package:warranty_app/services/db/auth_cloud_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final UserController userController = Get.find();
  Future login(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future register(String email, String password, String phoneNumber,
      String fullName) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        await AuthDBService(uid: user.uid)
            .savingUserData(fullName, email, phoneNumber);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
