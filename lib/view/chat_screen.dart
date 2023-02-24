// import 'package:curiosity_app/controller/chat_controller.dart';
// import 'package:curiosity_app/controller/chat_repository.dart';
// import 'package:curiosity_app/controller/read%20data/get_profile_pic.dart';
// import 'package:curiosity_app/controller/read%20data/get_user_name.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../models/message.dart';

// class ChatScreenOld extends StatefulWidget {
//   const ChatScreenOld(
//       {super.key,
//       required this.getProfilePic,
//       required this.getUser,
//       required this.uid});

//   final GetUserName getUser;
//   final GetProfilePic getProfilePic;
//   final String uid;

//   @override
//   State<ChatScreenOld> createState() => _ChatScreenOldState();
// }

// class _ChatScreenOldState extends State<ChatScreenOld> {
//   final TextEditingController _messageController = TextEditingController();

//   String currentUserId = FirebaseAuth.instance.currentUser!.uid;

//   ChatController chatController = ChatController();

//   void sendTextMessage(BuildContext context) {
//     chatController.sendTextMessage(
//         context: context,
//         text: _messageController.text.trim(),
//         recieverUserId: widget.uid);
//     setState(() {
//       _messageController.text = '';
//     });
//   }

//   _buildMessage(String message, bool isMe, BuildContext context, String time) {
//     final container = Container(
//       margin: isMe
//           ? const EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//               left: 80.0,
//             )
//           : const EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//             ),
//       padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//       width: MediaQuery.of(context).size.width * 0.75,
//       decoration: BoxDecoration(
//         color: isMe
//             ? Theme.of(context).colorScheme.secondary
//             : const Color(0xFFFFEFEE),
//         borderRadius: isMe
//             ? const BorderRadius.only(
//                 topLeft: Radius.circular(15.0),
//                 bottomLeft: Radius.circular(15.0),
//               )
//             : const BorderRadius.only(
//                 topRight: Radius.circular(15.0),
//                 bottomRight: Radius.circular(15.0),
//               ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             time,
//             style: const TextStyle(
//               color: Colors.grey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             message,
//             style: const TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );

//     if (isMe) {
//       return container;
//     }

//     return Row(
//       children: <Widget>[
//         container,
//         // IconButton(
//         //   icon: message.isLiked
//         //       ? const Icon(Icons.favorite)
//         //       : const Icon(Icons.favorite_border),
//         //   iconSize: 30.0,
//         //   color: message.isLiked
//         //       ? Theme.of(context).primaryColor
//         //       : Colors.blueGrey,
//         //   onPressed: () {},
//         // ),
//       ],
//     );
//   }

//   _buildMessageComposer(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       height: 70.0,
//       color: Colors.white,
//       child: Row(
//         children: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.attach_file),
//             iconSize: 25.0,
//             color: Theme.of(context).primaryColor,
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               textCapitalization: TextCapitalization.sentences,
//               onChanged: (value) {},
//               decoration: const InputDecoration.collapsed(
//                 hintText: 'Send a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             iconSize: 25.0,
//             color: Theme.of(context).primaryColor,
//             onPressed: () {
//               sendTextMessage(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.black87,
//         title: Row(
//           children: [
//             widget.getProfilePic,
//             const SizedBox(
//               width: 10,
//             ),
//             widget.getUser,
//           ],
//         ),
//         elevation: 0.0,
//         // actions: <Widget>[
//         //   IconButton(
//         //     icon: const Icon(Icons.more_horiz),
//         //     iconSize: 10,
//         //     color: Colors.white,
//         //     onPressed: () {},
//         //   ),
//         // ],
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//                   child: StreamBuilder<List<Message>>(
//                       stream: ChatRepository().getChatStream(widget.uid),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         }

//                         return ListView.builder(
//                           reverse: true,
//                           padding: const EdgeInsets.only(top: 15.0),
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             final message = snapshot.data![index];

//                             final bool isMe = message.senderId == currentUserId;
//                             return _buildMessage(message.text, isMe, context,
//                                 message.timeSent as String);
//                           },
//                         );
//                       }),
//                 ),
//               ),
//             ),
//             _buildMessageComposer(context),
//           ],
//         ),
//       ),
//     );
//   }
// }
