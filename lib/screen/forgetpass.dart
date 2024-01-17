import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inso_cur/components/inputField.dart';
import 'package:inso_cur/components/roundButton.dart';
import 'package:inso_cur/routs/routename.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ForgetPass> {
  var email = TextEditingController();
  var fkey = GlobalKey<FormState>();
  @override
  void fortgetpass() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email.text)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Check your email"),
      ));
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              child: Center(
                child: Form(
                  key: fkey,
                  child: Column(
                    children: [
                      Text(
                        "Forget Password",
                        style: TextStyle(fontSize: 35),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Please enter your email address. You will receive a link to create a new password via email.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      inputField(
                          icons: Icons.alternate_email,
                          hint: "Email",
                          fieldController: email,
                          validator: (_) {
                            if (email.text.isEmpty) {
                              return "Email is Empty";
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      roundButton(
                          title: "Send",
                          ontap: () {
                            if (fkey.currentState!.validate()) {
                              fortgetpass();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Email is Empty"),
                              ));
                            }
                          })
                    ],
                  ),
                ),
              ),
            )));
  }
}
