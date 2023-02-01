import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return Response.bytes(
    body: File('public/index.html').readAsBytesSync(),
    headers: {'Content-Type': 'text/html'},
  );
}
