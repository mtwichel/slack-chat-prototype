import 'package:api/message.dart';
import 'package:api/message_stream.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final message = Message(
    content: await context.request.body(),
    senderId: 'slack',
    sentAt: DateTime.now().millisecondsSinceEpoch,
  );
  messagesStreamController.add(message);
  return Response();
}
