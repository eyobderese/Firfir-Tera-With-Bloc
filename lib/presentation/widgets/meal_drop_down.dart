import 'package:firfir_tera/bloc/createRecipe/create_recipe_bloc.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_event.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealTypeDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: state.recipeCatagory,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            context
                .read<CreateRecipeBloc>()
                .add(RecipeCategoryChanged(recipeCategory: newValue!));
          },
          items: <String>['Breakfast', 'Lunch', 'Dinner']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }
}
