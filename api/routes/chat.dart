import 'dart:convert';

import 'package:api/message.dart';
import 'package:api/message_stream.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler((channel, protocol) {
    final streamSubscription = messagesStreamController.stream.listen((event) {
      channel.sink.add(jsonEncode(event.toJson()));
    });
    channel.stream.listen(
      (e) {
        final json = Map<String, dynamic>.from(jsonDecode('$e') as Map);
        messagesStreamController.add(Message.fromJson(json));
      },
      onDone: streamSubscription.cancel,
    );
  });
  return handler(context);
}
