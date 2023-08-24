import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:warranty_app/models/User/user_model.dart';

class UserCloudHelper{
  CollectionReference userCollection = FirebaseFirestore.instance.collection("User");
  String uid = FirebaseAuth.instance.currentUser!.uid;

}