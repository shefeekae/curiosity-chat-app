import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetProfilePic extends StatelessWidget {
  GetProfilePic({super.key, required this.documentId});
  final String documentId;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          bool isUrlValid = Uri.parse(data['profilePic']).host.isNotEmpty;

          if (isUrlValid) {
            return CircleAvatar(
              backgroundImage: NetworkImage(data['profilePic']),
            );
          } else {
            return CircleAvatar(
              backgroundImage: AssetImage(data['profilePic']),
            );
          }
        }
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.png'),
        );
      },
    );
  }
}
