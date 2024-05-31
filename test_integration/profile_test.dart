import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Profile Feature Integration Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final profilePageButton = find.byKey(Key('profilePageButton'));

    await tester.tap(profilePageButton);
    await tester.pumpAndSettle();

    final editProfileButton = find.byKey(Key('editProfileButton'));
    final nameField = find.byKey(Key('nameField'));
    final bioField = find.byKey(Key('bioField'));
    final saveProfileButton = find.byKey(Key('saveProfileButton'));

    await tester.tap(editProfileButton);
    await tester.pumpAndSettle();

    await tester.enterText(nameField, 'Test User');
    await tester.pumpAndSettle();

    await tester.enterText(bioField, 'This is a test bio.');
    await tester.pumpAndSettle();

    await tester.tap(saveProfileButton);
    await tester.pumpAndSettle();

    expect(find.text('Profile updated!'), findsOneWidget);
  });
}
