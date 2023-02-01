import 'dart:convert';
import 'dart:io';

import 'package:api/message_stream.dart';
import 'package:api/slack_token.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:http/http.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  messagesStreamController.stream.listen(
    (event) {
      messages.add(event);
      if (event.senderId == 'client') {
        post(
          Uri.parse('https://slack.com/api/chat.postMessage'),
          body: jsonEncode(
            {'channel': 'C04MH8BCMNE', 'text': event.content},
          ),
          headers: {
            'Content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
      }
    },
  );
  // 1. Execute any custom code prior to starting the server...

  // 2. Use the provided `handler`, `ip`, and `port` to create a custom `HttpServer`.
  // Or use the Dart Frog serve method to do that for you.
  return serve(handler, ip, port);
}
