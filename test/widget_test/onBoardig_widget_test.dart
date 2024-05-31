import 'package:firfir_tera/presentation/pages/onBoarding/screen/onboarding_1.dart';
import 'package:firfir_tera/presentation/pages/onBoarding/screen/onboarding_2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('OnBoarding_1 widget should show', (WidgetTester tester) async {
    // Arrange
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: OnBoarding_2(),
      ),
    );

    // Assert
    expect(find.byType(OnBoarding_2), findsOneWidget);
  });
}
