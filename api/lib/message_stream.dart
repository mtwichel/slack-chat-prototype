import 'dart:async';

import 'package:api/message.dart';

final _controller = StreamController<Message>();
Stream<Message> get messagesStream => _controller.stream.asBroadcastStream();
void addMessage(Message message) {
  _controller.add(message);
}
