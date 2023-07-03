import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/core/snackbar.dart';
import 'package:flutter_chatgpt/features/repository/chat_repository.dart';
import 'package:flutter_chatgpt/features/widgets/chat_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Link for api - https://beta.openai.com/account/api-keys

final openAIBuildProvider = Provider<OpenAI?>(
  (ref) => OpenAI.instance.build(
      token: 'YOUR_API_KEY', // TODO: Add your own api key.
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60))),
);

final isLoadingProvider = StateProvider<bool>((ref) => false);

final chatControllerProvider =
    StateNotifierProvider<ChatController, List<ChatMessage>>(
  (ref) => ChatController(
    chatRepository: ref.watch(chatRepositoryProvider),
    ref: ref,
  ),
);

class ChatController extends StateNotifier<List<ChatMessage>> {
  final ChatRepository _chatRepository;
  final Ref _ref;
  ChatController({required ChatRepository chatRepository, required Ref ref})
      : _chatRepository = chatRepository,
        _ref = ref,
        super([]);

  void sendMsg(BuildContext context, ChatMessage message) async {
    _ref.read(isLoadingProvider.notifier).update((state) => true);
    state = [message, ...state];
    final response = await _chatRepository.insertMsgData(message.text);
    response.fold(
        (failed) =>
            showSnackBar(context, 'CHATGPT could not respond at the moment'),
        (response) {
      ChatMessage botMessage = ChatMessage(
        text: response!.choices[0].text,
        sender: "bot",
      );
      _ref.read(isLoadingProvider.notifier).update((state) => false);
      state = [botMessage, ...state];
    });
  }
}
