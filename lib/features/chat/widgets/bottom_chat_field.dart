import 'package:curiosity_app/controller/chat_controller.dart';
import 'package:flutter/material.dart';

class BottomChatField extends StatefulWidget {
  final String recieverUserId;
  const BottomChatField({super.key, required this.recieverUserId});

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  final TextEditingController _messageController = TextEditingController();

  ChatController chatController = ChatController();

  void sendTextMessage() {
    chatController.sendTextMessage(
        context: context,
        text: _messageController.text.trim(),
        recieverUserId: widget.recieverUserId);
    setState(() {
      _messageController.text = '';
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 20),
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 18,
            right: 10,
            left: 5,
          ),
          child: GestureDetector(
            onTap: sendTextMessage,
            child: const Icon(
              Icons.send,
              size: 30,
              color: Color(0xFF128C7E),
            ),
          ),
        ),
      ],
    );
  }
}
