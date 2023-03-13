import 'package:curiosity_app/controller/auth_controller.dart';
import 'package:curiosity_app/controller/read%20data/get_user_name.dart';
import 'package:curiosity_app/features/chat/widgets/bottom_chat_field.dart';
import 'package:curiosity_app/features/chat/widgets/chat_list.dart';
import 'package:curiosity_app/models/chat_contact.dart';
import 'package:flutter/material.dart';

import '../../../controller/read data/get_profile_pic.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {super.key,
      required this.getUser,
      required this.getProfilePic,
      required this.uid});

  final GetUserName getUser;
  final GetProfilePic getProfilePic;
  final String uid;

  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: StreamBuilder(
            stream: authController.userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading ...');
              }

              return Row(
                children: [
                  getProfilePic,
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      getUser,
                      Text(
                        snapshot.data!.isOnline ? 'Online' : 'Offline',
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  )
                ],
              );
            }),
        centerTitle: false,
        elevation: 0.0,
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.more_horiz),
        //     iconSize: 10,
        //     color: Colors.white,
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(recieverUserId: uid),
          ),
          BottomChatField(recieverUserId: uid)
        ],
      ),
    );
  }
}
