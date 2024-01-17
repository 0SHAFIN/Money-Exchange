import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inso_cur/routs/routename.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      Navigator.pushNamed(context, RouteName.homeScreen);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    });
  }

  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(hintText: "Email"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text("Login"))
            ],
          )),
    ));
  }
}
