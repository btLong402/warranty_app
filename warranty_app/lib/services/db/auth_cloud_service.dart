import 'package:cloud_firestore/cloud_firestore.dart';

class AuthDBService {
  final String uid;

  AuthDBService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future savingUserData(
      String fullName, String email, String phoneNumber) async {
    return await userCollection.doc(uid).set({
      "userName": fullName,
      "email": email,
      "contact": phoneNumber,
      "role": 0,
      "userId": uid,
    });
  }

  Future getUserData() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    return snapshot;
  }
}
