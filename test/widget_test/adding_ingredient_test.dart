import 'package:firfir_tera/presentation/widgets/adding_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IngredientAdder Widget Test', () {
    testWidgets('Adds and removes ingredient lines correctly',
        (WidgetTester tester) async {

      await tester.pumpWidget(MaterialApp(home: IngredientAdder()));

      expect(find.byType(TextField), findsNWidgets(2));

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(); 

      expect(find.byType(TextField), findsNWidgets(4));

      await tester.enterText(find.byType(TextField).first, 'Flour');
      await tester.pump();

      await tester.enterText(find.byType(TextField).at(1), '1 cup');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.remove_circle).first);
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));

      expect(find.text('Flour'), findsNothing);
      expect(find.text('1 cup'), findsNothing);
    });
  });
}
