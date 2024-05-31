import 'package:firfir_tera/presentation/widgets/adding_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Initial state has two pairs of text fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IngredientAdder()));

    // Verify that initially there are 2 TextFields (one for ingredient and one for weight)
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('Add Ingredient button adds new pair of text fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IngredientAdder()));

    // Tap the "Add Ingredient" button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that after tapping the button, there are now 4 TextFields (two for ingredients and two for weights)
    expect(find.byType(TextField), findsNWidgets(4));
  });

  testWidgets('Remove Ingredient button removes a pair of text fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IngredientAdder()));

    // Tap the "Add Ingredient" button to add a new pair of text fields
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify there are now 4 TextFields
    expect(find.byType(TextField), findsNWidgets(4));

    // Tap the first "remove" button
    await tester.tap(find.byIcon(Icons.remove_circle).first);
    await tester.pump();

    // Verify that after tapping the remove button, there are 2 TextFields left
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets(
      'Remove Ingredient button does not remove other pairs when clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IngredientAdder()));

    // Tap the "Add Ingredient" button twice to add two new pairs of text fields
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify there are now 6 TextFields
    expect(find.byType(TextField), findsNWidgets(6));

    // Tap the second "remove" button
    await tester.tap(find.byIcon(Icons.remove_circle).at(1));
    await tester.pump();

    // Verify that there are 4 TextFields left (2 pairs)
    expect(find.byType(TextField), findsNWidgets(4));
  });
}
