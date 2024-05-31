import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Comment Page Integration Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final commentField = find.byKey(Key('commentField'));
    final submitButton = find.byKey(Key('submitButton'));

    await tester.enterText(commentField, 'This is a test comment.');
    await tester.pumpAndSettle();

    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    expect(find.text('Comment submitted!'), findsOneWidget);
  });
}
