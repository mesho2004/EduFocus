import 'package:flutter_test/flutter_test.dart';
import 'package:edufocus/main.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const EdufocusApp());

    // Verify that splash screen content is displayed.
    expect(find.text('Learning that feels like playing.'), findsOneWidget);
  });
}
