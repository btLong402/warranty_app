import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:warranty_app/models/User/user_model.dart';
import 'package:warranty_app/services/db/auth_cloud_service.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<UserModel> user = UserModel().obs;
  Future<void> getUserData() async {
    try {
      DocumentSnapshot snapshot =
          await AuthDBService(uid: _auth.currentUser!.uid).getUserData();
      if (snapshot.exists) {
        UserModel userData =
            UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
        user.value = UserModel().copyWith(
            email: userData.email,
            contact: userData.contact,
            role: userData.role,
            userId: userData.userId,
            userName: userData.userName);
        // print(user.value.toString());
      }
    } catch (e) {
      // failure('Error fetching user data!', e.toString());
      printError(info: e.toString());
    }
  }

  Future<void> clearUserData() async {
    user.value = UserModel();
  }
}
