import 'dart:async';
import 'dart:convert';

import 'package:chat_repository/chat_repository.dart';
import 'package:http/http.dart';
import 'package:web_socket_client/web_socket_client.dart';

/// {@template chat_repository}
/// Manages the chat domain
/// {@endtemplate}
class ChatRepository {
  /// {@macro chat_repository}
  ChatRepository({
    required this.host,
  }) : socket = WebSocket(Uri.parse('wss://$host/api/chat'));

  final String host;
  final WebSocket socket;

  Future<void> init() async {
    socket.connection.listen(print);
  }

  Stream<Message> get messageStream => socket.messages.map((e) {
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

  Future<List<Message>> getMessages() async {
    final response = await get(Uri.parse('https://$host/api/messages'));
    final body = Map<String, dynamic>.from(jsonDecode(response.body) as Map);
    return (body['messages'] as List)
        .map((e) => Message.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  void close() {
    socket.close();
  }
}
