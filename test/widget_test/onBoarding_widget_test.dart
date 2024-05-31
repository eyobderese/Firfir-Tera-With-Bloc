import 'package:firfir_tera/presentation/pages/onBoarding/screen/onboarding_3.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('OnBoarding_3 widget should show', (WidgetTester tester) async {
    // Arrange
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: OnBoarding_3(),
      ),
    );

    // Assert
    expect(find.byType(OnBoarding_3), findsOneWidget);
  });
}
