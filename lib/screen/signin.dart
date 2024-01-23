import 'package:flutter/material.dart';
import 'package:inso_cur/components/inputField.dart';
import 'package:inso_cur/components/roundButton.dart';
import 'package:inso_cur/routs/routename.dart';
import 'package:inso_cur/service/auth/login.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var usernamecntrl = TextEditingController();
  var passwordcntrl = TextEditingController();

  var checkBox = false;
  bool obsereText = true;
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * .1;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 80,
                      child: Image.asset("assets/images/inso_curr(logo).png"),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .2,
                ),
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome ",
                          style: TextStyle(fontSize: 35),
                        ),
                        Text(
                          "to Money Exchnage ",
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height * .4,
                ),
                inputField(
                    icons: Icons.alternate_email,
                    hint: "Email",
                    fieldController: usernamecntrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is Empty";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: height * .2,
                ),
                inputField(
                    obScureText: obsereText,
                    icons: Icons.lock,
                    hint: "Password",
                    fieldController: passwordcntrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is Empty";
                      } else {
                        return null;
                      }
                    }),
                Row(
                  children: [
                    Checkbox(
                        value: checkBox,
                        onChanged: (value) {
                          setState(() {
                            checkBox = value!;
                            if (value == true) {
                              obsereText = false;
                            } else {
                              obsereText = true;
                            }
                          });
                        }),
                    const Text("Show Password"),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.forgetpasScreen);
                        },
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(color: Color(0xff7d5fff)),
                        ))
                  ],
                ),
                SizedBox(
                  height: height * .1,
                ),
                ChangeNotifierProvider(
                  create: (context) => authintication(),
                  child: Consumer<authintication>(
                    builder: (context, value, child) => roundButton(
                        title: "Login",
                        loading: value.loading,
                        ontap: () {
                          if (formkey.currentState!.validate()) {
                            value.login(context, usernamecntrl.text,
                                passwordcntrl.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please Fill All Fields")));
                          }
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont Have Any Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.signupScreen);
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(color: Color(0xff7d5fff)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
