import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  const DisplayText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(fontSize: 16),
    );
  }
}
