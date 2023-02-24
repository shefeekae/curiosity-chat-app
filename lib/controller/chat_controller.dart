import 'package:curiosity_app/controller/auth_controller.dart';
import 'package:curiosity_app/controller/chat_repository.dart';
import 'package:curiosity_app/models/message.dart';
import 'package:curiosity_app/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatController {
  ChatRepository chatRepository = ChatRepository();

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
  }) async {
    AuthController authController = AuthController();
    UserModel? senderUser = await authController.getUserData();

    chatRepository.sendTextMessage(
        context: context,
        text: text,
        recieverUserId: recieverUserId,
        senderUser: senderUser!);
  }

  // Stream<List<Message>> chatStream(String recieverUserId) {
  //   return chatRepository.getChatStream(recieverUserId);
  // }
}
