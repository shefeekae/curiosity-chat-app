import 'dart:io';
import 'package:curiosity_app/components/my_textfield.dart';
import 'package:curiosity_app/controller/add_profile_image.dart';
import 'package:curiosity_app/controller/auth_repo.dart';
import 'package:curiosity_app/controller/sign_user_up.dart';
import 'package:curiosity_app/controller/validate.dart';
import 'package:flutter/material.dart';

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State<UserInformationPage> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  final TextEditingController nameController = TextEditingController();

  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  AuthRepo repo = AuthRepo();

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      await repo.saveUserDataToFirebase(context, name, image);
      setState(() {});
    }
  }

  UserRegister userRegister = UserRegister();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                'Profile Info',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),

              const Text(
                'Please provide your name and an optional profile photo',
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(
                height: 100,
              ),
              //add profile image
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: FileImage(image!),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                          setState(() {});
                        },
                        icon: const Icon(Icons.add_a_photo)),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              //add user name
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.85,
                    child: MyTextField(
                      controller: nameController,
                      hintText: 'Full Name',
                      obscureText: false,
                      validator: (value) {
                        return Validate.validateName(value);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        storeUserData();
                      });
                    },
                    icon: const Icon(Icons.done),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
