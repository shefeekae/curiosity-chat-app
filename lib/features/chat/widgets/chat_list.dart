import 'package:curiosity_app/controller/chat_controller.dart';
import 'package:curiosity_app/controller/chat_repository.dart';
import 'package:curiosity_app/features/chat/widgets/my_message_card.dart';
import 'package:curiosity_app/features/chat/widgets/sender_message_card.dart';
import 'package:curiosity_app/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key, required this.recieverUserId});

  final String recieverUserId;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ScrollController messageController = ScrollController();
  ChatController chatController = ChatController();

  ChatRepository chat = ChatRepository();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: chat.getChatStream(widget.recieverUserId),
      builder: (context, snapshot) {
        print(snapshot.data);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // SchedulerBinding.instance.addPostFrameCallback((_) {
        //   messageController.jumpTo(messageController.position.maxScrollExtent);
        // });

        return ListView.builder(
          controller: messageController,
          itemCount: chat.messages.length,
          itemBuilder: (context, index) {
            final messageData = snapshot.data![index];
            var time = DateFormat.Hm().format(messageData.timeSent);

            if (messageData.senderId ==
                FirebaseAuth.instance.currentUser!.uid) {
              return MyMessageCard(
                  message: messageData.text,
                  date: time,
                  type: messageData.type,
                  isSeen: messageData.isSeen);
            } else {
              return SenderMessageCard(
                message: messageData.text,
                date: time,
                isSeen: messageData.isSeen,
                type: messageData.type,
              );
            }
          },
        );
      },
    );
  }
}
