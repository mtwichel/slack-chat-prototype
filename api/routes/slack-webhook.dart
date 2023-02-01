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
    case 'event_callback':
      final event = Map<String, dynamic>.from(requestBody['event'] as Map);

      if (event['user'] == 'U04MVN0K16D') {
        return Response();
      }
      if (event['type'] == 'message' || event['type'] == 'app_mention') {
        final message = Message(
          content: event['text'] as String,
          senderId: 'slack',
          sentAt: DateTime.now().millisecondsSinceEpoch,
        );
        addMessage(message);
      }
  }

  return Response();
}
