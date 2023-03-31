import 'dart:io';
import 'package:curiosity_app/controller/sign_user_up.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  UserRegister user = UserRegister();

  saveUserDataToFirebase(BuildContext context, String name, File? profilePic) {
    user.saveUserDataToFirebase(
        name: name, profilePic: profilePic, context: context);
  }
}
