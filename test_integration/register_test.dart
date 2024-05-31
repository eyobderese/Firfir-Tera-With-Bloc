import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Register Page 1 Integration Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final emailField = find.byKey(Key('emailField'));
    final passwordField = find.byKey(Key('passwordField'));
    final accountTypeField = find.byKey(Key('accountTypeField'));
    final nextPageButton = find.byKey(Key('nextPageButton'));

    await tester.enterText(emailField, 'testuser@example.com');
    await tester.pumpAndSettle();

    await tester.enterText(passwordField, 'password');
    await tester.pumpAndSettle();

    await tester.tap(accountTypeField);
    await tester.pumpAndSettle();

    await tester.tap(nextPageButton);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('registerPage2')), findsOneWidget);
  });

  testWidgets("Register Page 2 Integration Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final firstNameField = find.byKey(Key('firstNameField'));
    final lastNameField = find.byKey(Key('lastNameField'));
    final bioField = find.byKey(Key('bioField'));
    final nextPageButton = find.byKey(Key('nextPageButton'));

    await tester.enterText(firstNameField, 'Test');
    await tester.pumpAndSettle();

    await tester.enterText(lastNameField, 'User');
    await tester.pumpAndSettle();

    await tester.enterText(bioField, 'This is a test user.');
    await tester.pumpAndSettle();

    await tester.tap(nextPageButton);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('registerPage3')), findsOneWidget);
  });

}
