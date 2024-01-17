import 'package:flutter/material.dart';
import 'package:inso_cur/components/inputField.dart';
import 'package:inso_cur/components/roundButton.dart';
import 'package:inso_cur/routs/routename.dart';
import 'package:inso_cur/screen/test_country_details.dart';
import 'package:inso_cur/service/auth/register.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool checkBox = false;
  bool obsereText = true;
  var fname = TextEditingController();
  var lname = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var selectedDate;
  var passsword = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * .1;

    void datePicker() async {
      final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1980),
              lastDate: DateTime.now())
          .then((value) {
        setState(() {
          selectedDate = " ${value!.day} | ${value!.month} | ${value!.year}";
        });
      });
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Column(
            children: [
              SizedBox(
                height: height * .5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome ",
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        "to Currency Exchange ",
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * .2,
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * .2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: inputField(
                            icons: Icons.person,
                            hint: "First Name",
                            fieldController: fname,
                            validator: (_) {}),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: inputField(
                            icons: Icons.person,
                            hint: "Last Name",
                            fieldController: lname,
                            validator: (_) {}),
                      )
                    ],
                  ),

                  SizedBox(
                    height: height * .2,
                  ),
                  inputField(
                      keyboard: TextInputType.number,
                      icons: Icons.phone,
                      hint: "Phone",
                      fieldController: phone,
                      validator: (_) {}),
                  SizedBox(
                    height: height * .2,
                  ),
                  InkWell(
                    onTap: datePicker,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 71, 71, 71),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Color.fromARGB(255, 189, 189, 189))),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: ListTile(
                              title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Date of Birth :",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 15)),
                              const SizedBox(
                                width: 10,
                              ),
                              selectedDate == null
                                  ? const Text(
                                      "Select your DOB",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15),
                                    )
                                  : Text(
                                      selectedDate.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ],
                          ))),
                    ),
                  ),
                  SizedBox(
                    height: height * .2,
                  ),
                  inputField(
                      icons: Icons.alternate_email,
                      hint: "Email",
                      fieldController: email,
                      validator: (_) {}),

                  //gender

                  SizedBox(
                    height: height * .2,
                  ),
                  inputField(
                      obScureText: obsereText,
                      icons: Icons.lock,
                      hint: "Password",
                      fieldController: passsword,
                      validator: (_) {}),
                  SizedBox(
                    height: height * .2,
                  ),
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
                    ],
                  ),
                  ChangeNotifierProvider(
                      create: (context) => register(),
                      child: Consumer<register>(
                        builder: (context, value, child) => roundButton(
                            loading: value.loading,
                            title: "SignUp",
                            ontap: () {
                              value.signup(
                                context,
                                fname.text,
                                lname.text,
                                phone.text,
                                selectedDate.toString(),
                                email.text,
                                passsword.text,
                              );
                            }),
                      )),
                  SizedBox(
                    height: height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have Account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.loginScreen);
                          },
                          child: const Text(
                            "SignIn",
                            style: TextStyle(color: Color(0xff7d5fff)),
                          ))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
