import 'package:flutter/material.dart';
import 'package:inso_cur/routs/routename.dart';
import 'package:inso_cur/screen/country_currency.dart';
import 'package:inso_cur/screen/forgetpass.dart';
import 'package:inso_cur/screen/home.dart';
import 'package:inso_cur/screen/profile.dart';
import 'package:inso_cur/screen/signin.dart';
import 'package:inso_cur/screen/singup.dart';
import 'package:inso_cur/screen/splshscreen.dart';
import 'package:inso_cur/service/profile_update.dart';
import 'package:inso_cur/temp/tempPlash.dart';

class Routs {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => const SignIn());
      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case RouteName.profil_Updateescreen:
        return MaterialPageRoute(builder: (context) => Profil_update());
      case RouteName.profilescreen:
        return MaterialPageRoute(builder: (context) => Profile());
      case RouteName.forgetpasScreen:
        return MaterialPageRoute(builder: (context) => ForgetPass());
      case RouteName.tempPlash:
        return MaterialPageRoute(builder: (context) => TempPlash());

      case RouteName.countryScreen:
        return MaterialPageRoute(
            builder: (context) => const CountryDetailsList());
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Text("Error"),
                ));
    }
  }
}
