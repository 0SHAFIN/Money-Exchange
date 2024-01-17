import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inso_cur/components/roundButton.dart';
import 'package:inso_cur/routs/routename.dart';

class Profil_update extends StatefulWidget {
  String? name;
  String? hint;
 
  Profil_update({super.key, this.name, this.hint});

  @override
  State<Profil_update> createState() => _Profil_updateState();
}

class _Profil_updateState extends State<Profil_update> {
  var user = FirebaseAuth.instance.currentUser!.uid;
  void updateName() async {
    await FirebaseFirestore.instance.collection('Users').doc(user).update({
      'name': edit.text,
    }).then((value) => Navigator.pushNamed(context, RouteName.profilescreen));
  }

  void updateEmail() async {
    await FirebaseFirestore.instance.collection('Users').doc(user).update({
      'email': edit.text,
    }).then((value) => Navigator.pushNamed(context, RouteName.profilescreen));
  }

  void updatePhone() async {
    await FirebaseFirestore.instance.collection('Users').doc(user).update({
      'phone': edit.text,
    }).then((value) => Navigator.pushNamed(context, RouteName.profilescreen));
  }

  void updateDob() async {
    await FirebaseFirestore.instance.collection('Users').doc(user).update({
      'dob': edit.text,
    }).then((value) => Navigator.pushNamed(context, RouteName.profilescreen));
  }

  @override
  var edit = TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            TextField(
              controller: edit,
              decoration: InputDecoration(
                  // prefixIcon: Icon(widget.icons),
                  prefixIconColor: const Color.fromARGB(255, 189, 189, 189),
                  hintText: widget.hint,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Color(0xff7d5fff))),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Color(0xff7d5fff))),
                  focusColor: const Color(0xff7d5fff),
                  filled: true,
                  fillColor: Color.fromARGB(255, 71, 71, 71)),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Expanded(
                  child: roundButton(
                      title: "Back",
                      ontap: () {
                        Navigator.pop(context);
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: roundButton(
                      title: "Update",
                      ontap: () {
                        if (widget.name == "Name") {
                          updateName();
                        } else if (widget.name == "Email") {
                          updateEmail();
                        } else if (widget.name == "Phone") {
                          updatePhone();
                        } else if (widget.name == "Dob") {
                          updateDob();
                        } else {
                          print("error");
                        }
                      }),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
