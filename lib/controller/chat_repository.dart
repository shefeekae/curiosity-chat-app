import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curiosity_app/common/enums/message_enum.dart';
import 'package:curiosity_app/controller/add_profile_image.dart';
import 'package:curiosity_app/models/chat_contact.dart';
import 'package:curiosity_app/models/message.dart';
import 'package:curiosity_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRepository({required this.auth, required this.firestore});

  void _saveDatatoUsersSubCollection({
    required UserModel senderUserData,
    required UserModel recieverUserData,
    required String text,
    required DateTime timeSent,
    required String recieverUserId,
  }) async {
    //users => reciever user id => chats => current user id => set data
    var recieverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    //users => current user id => chats => reciever user id => set data
    var senderChatContact = ChatContact(
        name: recieverUserData.name,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  Stream<List<ChatContact>> getChatContact() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());

        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage));
      }
      return contacts;
    });
  }

  Stream<List<Message>> getChatStream(String recieverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((snapshot) {
      List<Message> messages = [];

      // for (var document in snapshot.docs) {
      //   messages.add(Message.fromMap(document.data()));
      // }

      snapshot.docs.forEach((element) {
        messages.add(Message.fromMap(element.data()));
      });

      return messages;
    });
  }

  void _saveMessageToMessageSubCollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required MessageEnum messageType,
  }) async {
    final message = Message(
        senderId: auth.currentUser!.uid,
        recieverId: recieverUserId,
        text: text,
        type: messageType,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);

    //users => sender id => reciever id => messages => message id => store message
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );

    //users => reciever id => sender id => messages => message id => store message

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String recieverUserId,
      required UserModel senderUser}) async {
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;

      //users => sender id => reciever id => messages => message id => store message

      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();

      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v1();

      _saveDatatoUsersSubCollection(
        senderUserData: senderUser,
        recieverUserData: recieverUserData,
        text: text,
        timeSent: timeSent,
        recieverUserId: recieverUserId,
      );

      _saveMessageToMessageSubCollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
      );
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverId,
    String messageId,
  ) async {
    try {
      //users => sender id => reciever id => messages => message id => store message
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(recieverId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});

      //users => reciever id => sender id => messages => message id => store message

      await firestore
          .collection('users')
          .doc(recieverId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
