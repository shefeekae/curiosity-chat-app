// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class GetUserUid extends StatelessWidget {
//   GetUserUid({super.key, required this.documentId});
//   final String documentId;

//   CollectionReference users = FirebaseFirestore.instance.collection('users');

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder: (context, snapshot) {
//         Map<String, dynamic> data =
//             snapshot.data!.data() as Map<String, dynamic>;

//         return data['uid']  ;
//       },
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class GetUserUid {
//   //document ID's
//   List<String> docIDs = [];

//   //get docIDs
//   Future getRecieverIDs() async {
//     docIDs.clear();
//     await FirebaseFirestore.instance
//         .collection('users')
//         .get()
//         .then((snapshot) => snapshot.docs.forEach((document) {
//               docIDs.add(document.reference.id);
//             }));
//   }
// }
