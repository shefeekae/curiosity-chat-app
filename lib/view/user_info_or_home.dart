import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curiosity_app/view/home_page.dart';
import 'package:curiosity_app/view/user_information_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInformationOrHomePage extends StatelessWidget {
  const UserInformationOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<DocumentSnapshot>(
      stream: users.doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const UserInformationPage();
        } else {
          return HomePage();
        }
      },
    );
  }
}
