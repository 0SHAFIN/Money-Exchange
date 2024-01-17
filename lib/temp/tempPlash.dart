import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inso_cur/routs/routename.dart';
import 'package:inso_cur/temp/login.dart';

class TempPlash extends StatefulWidget {
  const TempPlash({super.key});

  @override
  State<TempPlash> createState() => _TempPlashState();
}

class _TempPlashState extends State<TempPlash> {
  var user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, RouteName.homeScreen);
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Login()));
        Navigator.pushNamed(context, RouteName.loginScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * .1;
    return Scaffold(
      backgroundColor: Color(0xff302652),
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 3,
          ),
          Center(
            child: Container(
              height: 150,
              width: 150,
              child: Image.asset(
                "assets/images/inso_curr(logo).png",
              ),
            ),
          ),
          const SizedBox(
            height: 250,
          ),
          const SpinKitFadingCircle(
            color: Colors.white,
            size: 40,
          )
        ],
      ))),
    );
  }
}
