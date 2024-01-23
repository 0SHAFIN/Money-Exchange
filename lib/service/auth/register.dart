import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inso_cur/routs/routename.dart';

class register with ChangeNotifier {
  bool loading = false;
  void signup(BuildContext context, String fname, String lname, String phone,
      String dob, String email, String pass) async {
    loading = true;
    notifyListeners();
    var auth = FirebaseAuth.instance;
    var _firestore = FirebaseFirestore.instance.collection('Users');

    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        print("Signup Done");
        _firestore.doc(value.user!.uid.toString()).set({
          'name': fname + " " + lname,
          'phone': phone,
          'dob': dob,
          'email': email,
          'password': pass,
          'userId': value.user!.uid.toString(),
        }).then((value) {
          loading = false;
          notifyListeners();

          Navigator.pushNamed(context, RouteName.loginScreen);
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      });
    } catch (e) {
      throw ("error$e");
    }
  }
}
