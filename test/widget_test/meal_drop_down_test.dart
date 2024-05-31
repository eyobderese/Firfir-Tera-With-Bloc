import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/application/bloc/createRecipe/create_recipe_bloc.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/presentation/pages/recipe/bloc/create_recipe_event.dart';
import 'package:firfir_tera/presentation/pages/recipe/bloc/create_recipe_state.dart';
import 'package:firfir_tera/presentation/widgets/meal_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCreateRecipeBloc
    extends MockBloc<CreateRecipeEvent, CreateRecipeState>
    implements CreateRecipeBloc {}

void main() {
  group('MealTypeDropdown Widget Test', () {
    late MockCreateRecipeBloc mockCreateRecipeBloc;

    setUp(() {
      mockCreateRecipeBloc = MockCreateRecipeBloc();
    });

    
  });
}
