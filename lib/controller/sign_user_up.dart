import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curiosity_app/common/repositories/common_firebase_storage_repository.dart';
import 'package:curiosity_app/controller/add_profile_image.dart';
import 'package:curiosity_app/models/user_model.dart';
import 'package:curiosity_app/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegister {
  signUserUp(
      {required email,
      required password,
      required confirmPassword,
      required BuildContext context}) async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //try creating the user
    try {
      //check if password is confirmed
      if (password == confirmPassword) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {
        Navigator.pop(context);

        return passwordNotMatchMessage(context);
      }

      //Pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //Pop the loading circle
      Navigator.pop(context);

      //Wrong Email
      String errorMessage = e.code;
      //SHOW ERROR TO USER
      return emailAlreadyExist(errorMessage, context);
    }
  }

  //Wrong Password message popup
  passwordNotMatchMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Passwords don't match!"),
        );
      },
    );
  }

  //Email Already Exists message popup
  emailAlreadyExist(String errorMessage, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("User already exists"),
        );
      },
    );
  }

  saveUserDataToFirebase(
      {required String name,
      required File? profilePic,
      required BuildContext context}) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String photoUrl = 'assets/images/profile.png';

      if (profilePic != null) {
        photoUrl = await CommonFirebaseStorageRepository()
            .storeFileToFirebase('profilePic/$uid', profilePic);
      }

      var user =
          UserModel(profilePic: photoUrl, uid: uid, name: name, isOnline: true);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(user.toMap());
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
