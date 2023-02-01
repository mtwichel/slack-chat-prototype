import 'dart:async';
import 'dart:convert';

import 'package:chat_repository/chat_repository.dart';
import 'package:web_socket_client/web_socket_client.dart';

/// {@template chat_repository}
/// Manages the chat domain
/// {@endtemplate}
class ChatRepository {
  /// {@macro chat_repository}
  ChatRepository({
    required this.uri,
  }) : socket = WebSocket(Uri.parse(uri));

  final String uri;
  final WebSocket socket;

  Future<void> init() async {
    await socket.connection.firstWhere((state) => state is Connected);
  }

  Stream<Message> get messages => socket.messages.map((e) {
        final json = Map<String, dynamic>.from(jsonDecode('$e') as Map);
        return Message.fromJson(json);
      });

  void sendMessage(String message) {
    final json = Message(
      content: message,
      senderId: 'client',
      sentAt: DateTime.now().millisecondsSinceEpoch,
    ).toJson();
    socket.send(jsonEncode(json));
  }

  void close() {
    socket.close();
  }
}
