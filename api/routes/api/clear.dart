import 'package:api/message_stream.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  messages.clear();
  return Response();
}
