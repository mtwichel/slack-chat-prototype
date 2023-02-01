import 'dart:async';

import 'package:api/message.dart';

final messagesStreamController = StreamController<Message>.broadcast();

final messages = <Message>[];
