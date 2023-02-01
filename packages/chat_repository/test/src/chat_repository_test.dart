// ignore_for_file: prefer_const_constructors
import 'package:chat_repository/chat_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ChatRepository', () {
    test('can be instantiated', () {
      expect(ChatRepository(host: 'test'), isNotNull);
    });
  });
}
