import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inso_cur/components/roundButton.dart';
import 'package:inso_cur/routs/routename.dart';
import 'package:inso_cur/service/pickImage.dart';
import 'package:inso_cur/service/profile_update.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  File? image;
  Profile({super.key, this.image});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userId;
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? password;
  var dataImage;
  var value;
  void getData() async {
    userId = await FirebaseAuth.instance.currentUser!.uid;
    value = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .get()
        .then((value) {
      setState(() {
        name = value.data()!['name'];
        email = value.data()!['email'];
        phone = value.data()!['phone'];
        dob = value.data()!['dob'];
        password = value.data()!['password'];
        dataImage = value.data()!['image'];
      });
    }).onError((error, stackTrace) {
      print("Error: ${error}");
    });
    print("Name: ${name}");
    print("Email: ${email}");
    print("Image url: ${dataImage}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    //print(email);
  }

  void update(String name, String hint) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Profil_update(
        name: name,
        hint: hint,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: ChangeNotifierProvider(
              create: (_) => PickImage(),
              child: Consumer<PickImage>(
                  builder: (context, value, child) => Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: value.imageFile == null
                                ? dataImage == null
                                    ? const AssetImage(
                                        "assets/images/human.jpg")
                                    : NetworkImage(dataImage) as ImageProvider
                                : FileImage(value.imageFile!.absolute)
                                    as ImageProvider,
                          ),
                          SizedBox(
                            height: 25,
                            child: InkWell(
                              onTap: () {
                                value.Pick_Image(context);
                                // Navigator.pushNamed(
                                //     context, RouteName.profilescreen);
                              },
                              child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff7d5fff)),
                                child: const Icon(
                                  Icons.add,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
              //add margin on top of cards
            )),
            const SizedBox(
              height: 100,
            ),
            Card(
              child: ListTile(
                  title: Text(
                    "Name:\t ${name}",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      update("Name", name!);
                    },
                    icon: const Icon(Icons.edit),
                  )),
            ),
            Card(
              child: ListTile(
                  title: Text(
                    "Email:\t ${email}",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      update("Email", email!);
                    },
                    icon: const Icon(Icons.edit),
                  )),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Phone:\t ${phone}",
                  style: TextStyle(fontSize: 15),
                ),
                trailing: IconButton(
                  onPressed: () {
                    update("Phone", phone!);
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "DOB:\t ${dob}",
                  style: TextStyle(fontSize: 15),
                ),
                trailing: IconButton(
                  onPressed: () {
                    update("DOB", dob!);
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                roundButton(
                    title: "Back",
                    ontap: () {
                      Navigator.pushNamed(context, RouteName.homeScreen);
                    })
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
