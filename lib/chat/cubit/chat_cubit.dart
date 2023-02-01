import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.chatRepository,
  }) : super(const ChatState());

  final ChatRepository chatRepository;
  StreamSubscription<Message>? subscription;

  Future<void> init() async {
    final initialMessages = await chatRepository.getMessages();
    emit(state.copyWith(messages: initialMessages));
    subscription = chatRepository.messageStream.listen((event) {
      emit(
        state.copyWith(
          messages: [...state.messages, event]
            ..sort((a, b) => a.sentAt.compareTo(b.sentAt)),
        ),
      );
    });
  }

  void sendMessage() {
    if (state.text != '') {
      chatRepository.sendMessage(state.text!);
    }
    emit(state.copyWith(text: ''));
  }

  void updateText(String text) {
    emit(state.copyWith(text: text));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
