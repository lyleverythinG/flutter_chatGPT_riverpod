import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onPressed;
  const ChatTextField(
      {super.key, required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration.collapsed(
                  hintText: "Question/description"),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: onPressed,
          ),
        ],
      ).px16(),
    );
  }
}
