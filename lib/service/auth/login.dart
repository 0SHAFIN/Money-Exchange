import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inso_cur/routs/routename.dart';

class authintication with ChangeNotifier {
  bool loading = false;
  void login(BuildContext context, String email, String pass) async {
    loading = true;
    notifyListeners();
    var auth = FirebaseAuth.instance;
    try {
      var user = await auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        loading = false;
        notifyListeners();
        Navigator.pushNamed(context, RouteName.homeScreen);
      }).onError((error, stackTrace) {
        loading = false;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    } catch (ex) {
      SnackBar(content: Text(ex.toString()));
    }
  }
}
