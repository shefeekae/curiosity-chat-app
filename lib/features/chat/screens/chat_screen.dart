import 'package:curiosity_app/controller/read%20data/get_user_name.dart';
import 'package:curiosity_app/features/chat/widgets/bottom_chat_field.dart';
import 'package:curiosity_app/features/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';

import '../../../controller/read data/get_profile_pic.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {super.key,
      required this.getUser,
      required this.getProfilePic,
      required this.uid});

  final GetUserName getUser;
  final GetProfilePic getProfilePic;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            getProfilePic,
            const SizedBox(
              width: 10,
            ),
            getUser,
          ],
        ),
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
