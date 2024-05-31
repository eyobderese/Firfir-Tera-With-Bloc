import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/application/bloc/createRecipe/create_recipe_bloc.dart';
import 'package:firfir_tera/presentation/pages/recipe/bloc/create_recipe_event.dart';
import 'package:firfir_tera/presentation/pages/recipe/bloc/create_recipe_state.dart';
import 'package:firfir_tera/presentation/widgets/meal_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock CreateRecipeBloc
class MockCreateRecipeBloc
    extends MockBloc<CreateRecipeEvent, CreateRecipeState>
    implements CreateRecipeBloc {}

void main() {
  late CreateRecipeBloc createRecipeBloc;

  setUp(() {
    createRecipeBloc = MockCreateRecipeBloc();
  });

  tearDown(() {
    createRecipeBloc.close();
  });

  testWidgets('MealTypeDropdown displays correct initial value',
      (WidgetTester tester) async {
    // Set up the initial state
    // when(() => createRecipeBloc.state).thenReturn(
    //     CreateRecipeState(fasting: 'Fasting', recipeCatagory: 'Breakfast'));

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CreateRecipeBloc>.value(
          value: createRecipeBloc,
          child: MealTypeDropdown(),
        ),
      ),
    );

    // Verify the dropdown displays the initial value
    final dropdownFinder = find.byKey(const Key('meal_type_dropdown'));
    expect(dropdownFinder, findsOneWidget);

    final dropdown = tester.widget<DropdownButton<String>>(dropdownFinder);
    expect(dropdown.value, 'Breakfast');
  });

  testWidgets('MealTypeDropdown calls bloc event on selection change',
      (WidgetTester tester) async {
    // Set up the initial state
    // when(() => createRecipeBloc.state).thenReturn(
    //     CreateRecipeState(fasting: 'Fasting', recipeCatagory: 'Breakfast'));

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CreateRecipeBloc>.value(
          value: createRecipeBloc,
          child: MealTypeDropdown(),
        ),
      ),
    );

    // Open the dropdown
    await tester.tap(find.byKey(const Key('meal_type_dropdown')));
    await tester.pumpAndSettle();

    // Tap the second option
    await tester.tap(find.text('Lunch').last);
    await tester.pumpAndSettle();

    // Verify the bloc event is called
    verify(() => createRecipeBloc
        .add(RecipeCategoryChanged(recipeCategory: 'Lunch'))).called(1);
  });
}
