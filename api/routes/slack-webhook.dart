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
  // final message = Message(
  //   content: await context.request.body(),
  //   senderId: 'slack',
  //   sentAt: DateTime.now(),
  // );
  // addMessage(message);
  return Response();
}
