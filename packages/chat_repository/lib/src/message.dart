import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message extends Equatable {
  const Message({
    required this.content,
    required this.sentAt,
    required this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] as String,
      sentAt: DateTime.parse(json['sent_at'] as String),
      senderId: json['sender_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'sent_at': sentAt.toIso8601String(),
        'sender_id': senderId,
      };

  final String content;
  final DateTime sentAt;
  final String senderId;

  @override
  List<Object> get props => [content, sentAt, senderId];
}
