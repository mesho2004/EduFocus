import 'package:flutter_test/flutter_test.dart';
import 'package:edufocus/main.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const EdufocusApp());

    expect(find.text('Learning that feels like playing.'), findsOneWidget);
  });
}
