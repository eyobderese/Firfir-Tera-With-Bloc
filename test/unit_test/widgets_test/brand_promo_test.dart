import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  testWidgets('BrandPromo widget displays image and texts with correct styles',
      (WidgetTester tester) async {
    // Define a test color
    const testColor = Colors.red;

    // Create the widget and trigger a frame
    await tester.pumpWidget(MaterialApp(home: BrandPromo(color: testColor)));

    // Verify the image is displayed
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    expect((tester.widget(imageFinder) as Image).image,
        AssetImage('assets/icons/cutlery.png'));

    // Verify the main text is displayed with correct style
    final mainTextFinder = find.text('FirfirTera');
    expect(mainTextFinder, findsOneWidget);
    Text mainTextWidget = tester.widget(mainTextFinder);
    expect(mainTextWidget.style?.fontSize, 40);
    expect(mainTextWidget.style?.fontWeight, FontWeight.w600);
    expect(mainTextWidget.style?.color, testColor);

    // Verify the subtitle text is displayed with correct style
    final subtitleTextFinder =
        find.text('Taste, Share, Create: Recipe Harmony.');
    expect(subtitleTextFinder, findsOneWidget);
    Text subtitleTextWidget = tester.widget(subtitleTextFinder);
    expect(subtitleTextWidget.style?.fontSize, 15);
    expect(subtitleTextWidget.style?.color, testColor);
    expect(subtitleTextWidget.textAlign, TextAlign.center);
  });

  testWidgets('BrandPromo widget uses default color when no color is provided',
      (WidgetTester tester) async {
    // Create the widget and trigger a frame without passing a color
    await tester.pumpWidget(MaterialApp(home: BrandPromo(color: Colors.black)));

    // Verify the main text is displayed with the default color
    final mainTextFinder = find.text('FirfirTera');
    expect(mainTextFinder, findsOneWidget);
    Text mainTextWidget = tester.widget(mainTextFinder);
    expect(mainTextWidget.style?.color, Colors.black);

    // Verify the subtitle text is displayed with the default color
    final subtitleTextFinder =
        find.text('Taste, Share, Create: Recipe Harmony.');
    expect(subtitleTextFinder, findsOneWidget);
    Text subtitleTextWidget = tester.widget(subtitleTextFinder);
    expect(subtitleTextWidget.style?.color, Colors.black);
  });
}
