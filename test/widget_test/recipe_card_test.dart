import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:firfir_tera/presentation/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RecipeCard Widget Test', () {
    late Recipe testRecipe;

    setUp(() {
      testRecipe = Recipe(
        id: '1',
        name: 'Test Recipe',
        description: 'A delicious test recipe',
        ingredients: ['Ingredient 1', 'Ingredient 2'],
        steps: ['Step 1', 'Step 2'],
        image: 'assets/images/kikil.jpg',
        cookTime: 30,
        people: 2,
        type: Category.Lunch,
        fasting: 'Non-Fasting',
      );
    });

    testWidgets('RecipeCard builds without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 1000, 
              child: RecipeCard(recipe: testRecipe),
            ),
          ),
        ),
      );

      expect(find.byType(RecipeCard), findsOneWidget);

      expect(find.text('Test Recipe'), findsOneWidget);
    });
  });
}