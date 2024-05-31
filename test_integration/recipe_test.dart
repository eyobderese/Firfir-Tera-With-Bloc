import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Recipe Feature Integration Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final createRecipeButton = find.byKey(Key('createRecipeButton'));
    final recipeNameField = find.byKey(Key('recipeNameField'));
    final recipeDescriptionField = find.byKey(Key('recipeDescriptionField'));
    final saveRecipeButton = find.byKey(Key('saveRecipeButton'));

    await tester.tap(createRecipeButton);
    await tester.pumpAndSettle();

    await tester.enterText(recipeNameField, 'Test Recipe');
    await tester.pumpAndSettle();

    await tester.enterText(recipeDescriptionField, 'This is a test recipe.');
    await tester.pumpAndSettle();

    await tester.tap(saveRecipeButton);
    await tester.pumpAndSettle();

    final editRecipeButton = find.byKey(Key('editRecipeButton'));
    final updatedRecipeDescriptionField =
        find.byKey(Key('updatedRecipeDescriptionField'));
    final updateRecipeButton = find.byKey(Key('updateRecipeButton'));

    await tester.tap(editRecipeButton);
    await tester.pumpAndSettle();

    await tester.enterText(
        updatedRecipeDescriptionField, 'This is an updated test recipe.');
    await tester.pumpAndSettle();

    await tester.tap(updateRecipeButton);
    await tester.pumpAndSettle();

    final viewRecipeButton = find.byKey(Key('viewRecipeButton'));

    await tester.tap(viewRecipeButton);
    await tester.pumpAndSettle();

    expect(find.text('This is an updated test recipe.'), findsOneWidget);
  });
}
