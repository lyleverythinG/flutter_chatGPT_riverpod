import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_chatgpt/core/failure.dart';
import 'package:flutter_chatgpt/core/typedefs.dart';
import 'package:flutter_chatgpt/features/controller/chat_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(ref: ref),
);

class ChatRepository {
  final Ref _ref;
  ChatRepository({required Ref ref}) : _ref = ref;
  FutureEither<CompleteResponse?> insertMsgData(String msgTxt) async {
    try {
      final request = CompleteText(prompt: msgTxt, model: TextDavinci3Model());
      final response =
          await _ref.read(openAIBuildProvider)!.onCompletion(request: request);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
