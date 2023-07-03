import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/core/threedots.dart';
import 'package:flutter_chatgpt/features/controller/chat_controller.dart';
import 'package:flutter_chatgpt/features/widgets/chat_message.dart';
import 'package:flutter_chatgpt/features/widgets/chat_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  late OpenAI? chatGPT;

  @override
  void initState() {
    chatGPT = ref.read(openAIBuildProvider);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendMessage(BuildContext context) {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "user",
    );
    ref.read(chatControllerProvider.notifier).sendMsg(context, message);
    _controller.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ChatApp + ChatGPT + RiverPod")),
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final msgs = ref.watch(chatControllerProvider);
                return Flexible(
                  child: ListView.builder(
                    reverse: true,
                    padding: Vx.m8,
                    itemCount: msgs.length,
                    itemBuilder: (context, index) {
                      return msgs[index];
                    },
                  ),
                );
              },
            ),
            if (ref.watch(isLoadingProvider)) const ThreeDots(),
            const Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: ChatTextField(
                controller: _controller,
                onPressed: () => _sendMessage(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
