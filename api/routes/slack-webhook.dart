import 'dart:convert';

import 'package:api/message.dart';
import 'package:api/message_stream.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final requestBody =
      Map<String, dynamic>.from(await context.request.json() as Map);

  final type = requestBody['type'] as String;

  switch (type) {
    case 'url_verification':
      final challenge = requestBody['challenge'] as String;
      return Response.json(body: {'challenge': challenge});
  }
  final message = Message(
    content: jsonEncode(requestBody),
    senderId: 'slack',
    sentAt: DateTime.now().millisecondsSinceEpoch,
  );
  addMessage(message);
  return Response();
}
