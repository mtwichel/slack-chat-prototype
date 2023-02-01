import 'package:flutter_test/flutter_test.dart';
import 'package:slack_chat/app/app.dart';
import 'package:slack_chat/chat/chat.dart';

void main() {
  group('App', () {
    testWidgets('renders ChatPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ChatPage), findsOneWidget);
    });
  });
}
