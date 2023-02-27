// ignore_for_file: must_be_immutable

import 'package:curiosity_app/controller/chat_controller.dart';
import 'package:curiosity_app/controller/chat_repository.dart';
import 'package:curiosity_app/controller/fetch_users.dart';
import 'package:curiosity_app/controller/read%20data/get_profile_pic.dart';
import 'package:curiosity_app/controller/read%20data/get_user_name.dart';
import 'package:curiosity_app/controller/read%20data/get_user_uid.dart';
import 'package:curiosity_app/features/chat/screens/chat_screen.dart';
import 'package:curiosity_app/models/chat_contact.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatelessWidget {
  ChatListView({super.key});

  FetchUsers users = FetchUsers();
  ChatController chatController = ChatController();
  // GetUserUid getUserUid = GetUserUid();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: users.getDocIDs(),
        builder: (context, docID) {
          return StreamBuilder<List<ChatContact>>(
              stream: chatController.chatContacts(),
              builder: (context, snapshot) {
                // getUserUid.getRecieverIDs();

                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    indent: 70,
                  ),
                  itemCount: users.docIDs.length,
                  itemBuilder: (context, index) {
                    // var chatContactData = snapshot.data![index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                uid: users.docIDs[index],
                                getProfilePic: GetProfilePic(
                                    documentId: users.docIDs[index]),
                                getUser: GetUserName(
                                    documentId: users.docIDs[index]),
                              ),
                            )),
                        child: ListTile(
                          leading:
                              GetProfilePic(documentId: users.docIDs[index]),
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                            child: GetUserName(documentId: users.docIDs[index]),
                          ),
                          // subtitle: Text(
                          //   chatContactData.lastMessage,
                          // ),
                          // trailing: Text(chat.time),
                        ),
                      ),
                    );
                  },
                );
              });
        });
  }
}
