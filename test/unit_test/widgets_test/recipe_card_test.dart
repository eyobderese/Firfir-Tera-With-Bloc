import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:firfir_tera/presentation/widgets/recipe_card.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late GoRouter router;

  setUp(() {
    router = MockGoRouter();
  });

  testWidgets('RecipeCard displays correct recipe details',
      (WidgetTester tester) async {

    // Build the widget
    var recipe;
    await tester.pumpWidget(
      MaterialApp(
        home: RecipeCard(recipe: recipe),
      ),
    );

    // Verify the image is displayed
    expect(find.byType(Image), findsOneWidget);
    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, isInstanceOf<AssetImage>());
    expect((image.image as AssetImage).assetName, 'assets/test_image.png');

    // Verify the recipe name is displayed
    expect(find.text('Test Recipe'), findsOneWidget);
  });

  testWidgets('RecipeCard navigates to correct route on tap',
      (WidgetTester tester) async {

    // Build the widget with mocked navigation
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            var recipe;
            return RecipeCard(recipe: recipe);
          },
        ),
      ),
    );

    // Simulate a tap on the card
    await tester.tap(find.byType(RecipeCard));
    await tester.pumpAndSettle();

    // Verify the navigation method was called
    verify(() => router.go('/detailed_recipe_view/1')).called(1);
  });
}
