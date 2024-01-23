import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inso_cur/screen/profile.dart';

class PickImage with ChangeNotifier {
  bool loading = false;
  void uploadImage(context) async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var ref = await firebase_storage.FirebaseStorage.instance.ref(userId);
      var upload = ref.putFile(imageFile!.absolute);
      await Future.value(upload);
      var url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update({'image': url}).then((value) {
        print("Image Uploaded");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(
                      image: imageFile,
                    )));
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    } catch (e) {
      print(e);
    }
  }

  final _picker = ImagePicker();
  File? imageFile;
  Future getImage(context) async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      if (image != null) {
        imageFile = File(image.path);
        uploadImage(context);
      } else {
        print('No image selected.');
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future getImageCamera(context) async {
    try {
      final image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      if (image != null) {
        imageFile = File(image.path);
        uploadImage(context);
      } else {
        print('No image selected.');
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void Pick_Image(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Camera"),
                    onTap: () {
                      getImageCamera(context);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text("Gallery"),
                    onTap: () {
                      getImage(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
