part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.text,
  });

  final List<Message> messages;
  final String? text;

  @override
  List<Object?> get props => [messages, text];

  ChatState copyWith({
    List<Message>? messages,
    String? text,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      text: text ?? this.text,
    );
  }
}
