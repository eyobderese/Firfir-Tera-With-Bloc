import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login Integration Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final usernameField = find.byKey(Key('usernameField'));
    final passwordField = find.byKey(Key('passwordField'));

    await tester.enterText(usernameField, 'testuser');
    await tester.pumpAndSettle();

    await tester.enterText(passwordField, 'password');
    await tester.pumpAndSettle();

    final loginButton = find.byKey(Key('loginButton'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();
    expect(find.byKey(Key('logoutButton')), findsOneWidget);
  });
}
