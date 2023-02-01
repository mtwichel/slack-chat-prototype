import 'dart:io';

import 'package:api/message_stream.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  return Response.json(
    body: {'messages': messages.map((e) => e.toJson()).toList()},
  );
}
