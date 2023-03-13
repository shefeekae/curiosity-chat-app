import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curiosity_app/models/chat_contact.dart';
import 'package:flutter/material.dart';

class GetProfilePic extends StatelessWidget {
  GetProfilePic({super.key, required this.chatContactData});
  ChatContact chatContactData;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    bool isUrlValid = Uri.parse(chatContactData.profilePic).host.isNotEmpty;

    if (isUrlValid) {
      return CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(chatContactData.profilePic),
      );
    } else {
      return const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/profile.png'),
      );
    }
  }
}
