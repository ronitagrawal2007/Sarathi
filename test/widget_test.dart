import 'package:flutter_test/flutter_test.dart';

import 'package:sarathi/main.dart';

void main() {
  testWidgets('starts on the Sarathi welcome screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text("Namaste! I'm Sarathi."), findsOneWidget);
    expect(find.text("Let's begin"), findsOneWidget);
  });
}
