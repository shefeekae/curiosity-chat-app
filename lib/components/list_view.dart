// ignore_for_file: must_be_immutable

import 'package:curiosity_app/components/list_view_shimmer.dart';
import 'package:curiosity_app/controller/chat_controller.dart';
import 'package:curiosity_app/controller/fetch_users.dart';
import 'package:curiosity_app/controller/read%20data/get_profile_pic.dart';
import 'package:curiosity_app/controller/read%20data/get_user_name.dart';
import 'package:curiosity_app/features/chat/screens/chat_screen.dart';
import 'package:curiosity_app/models/chat_contact.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ChatListView extends StatelessWidget {
  ChatListView({super.key});

  FetchUsers users = FetchUsers();
  ChatController chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: users.getDocIDs(),
        builder: (context, docID) {
          return StreamBuilder<List<ChatContact>>(
              stream: chatController.chatContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListViewShimmer();
                }

                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    indent: 70,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var chatContactData = snapshot.data![index];

                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              uid: chatContactData.contactId,
                              getProfilePic: GetProfilePic(
                                chatContactData: chatContactData,
                              ),
                              getUser: GetUserName(
                                  documentId: chatContactData.contactId),
                            ),
                          )),
                      child: ListTile(
                        leading:
                            GetProfilePic(chatContactData: chatContactData),
                        title: Text(
                          chatContactData.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          chatContactData.lastMessage,
                          maxLines: 2,
                        ),
                        trailing: Text(
                            DateFormat.Hm().format(chatContactData.timeSent)),
                      ),
                    );
                  },
                );
              });
        });
  }
}
