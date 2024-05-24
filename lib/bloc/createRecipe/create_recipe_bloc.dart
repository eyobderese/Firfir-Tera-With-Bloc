// create_recipe_bloc.dart

import 'package:firfir_tera/Repository/recipe_repositery.dart';
import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_event.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  final ImagePicker _picker = ImagePicker();
  final RecipeRepository recipeRepository;

  CreateRecipeBloc({required this.recipeRepository})
      : super(CreateRecipeState(
          controllers: List.generate(6, (_) => TextEditingController()),
          recipeName: '',
          recipeServes: '',
          recipeCookingtime: '',
          recipeCatagory: 'Breakfast',
          recipeDescription: '',
          formSubmissionStatus: const InitialFormStatus(),
        )) {
    on<AddLine>((event, emit) {
      final controllers = List<TextEditingController>.from(state.controllers);
      controllers.add(TextEditingController());
      controllers.add(TextEditingController());
      emit(state.copyWith(
          controllers: controllers,
          formSubmissionStatus: const InitialFormStatus()));
    });

    on<RemoveLine>((event, emit) {
      final controllers = List<TextEditingController>.from(state.controllers);
      controllers.removeAt(event.index);
      controllers.removeAt(event.index);
      emit(state.copyWith(
          controllers: controllers,
          formSubmissionStatus: const InitialFormStatus()));
    });

    on<PickImage>((event, emit) async {
      final pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(state.copyWith(
            image: pickedFile,
            formSubmissionStatus: const InitialFormStatus()));
      }
      print(pickedFile?.path);
    });

    on<RecipeNameChanged>((event, emit) {
      emit(state.copyWith(
          recipeName: event.name,
          formSubmissionStatus: const InitialFormStatus()));
    });
    on<RecipeCategoryChanged>((event, emit) {
      emit(state.copyWith(
          recipeCatagory: event.recipeCategory,
          formSubmissionStatus: const InitialFormStatus()));
    });
    on<RecipeDescriptionChanged>((event, emit) {
      emit(state.copyWith(
          recipeDescription: event.recipeDescription,
          formSubmissionStatus: const InitialFormStatus()));
    });

    on<RecipeServesChanged>((event, emit) {
      emit(state.copyWith(
          recipeServes: event.serves,
          formSubmissionStatus: const InitialFormStatus()));
    });

    on<RecipeCookingTimeChanged>((event, emit) {
      emit(state.copyWith(
          recipeCookingtime: event.cookingTime,
          formSubmissionStatus: const InitialFormStatus()));
    });

    on<SubmitRecipe>((event, emit) async {
      emit(state.copyWith(formSubmissionStatus: FormSubmitting()));

      List<Map<String, String>> ingredients = [];
      final controllers = state.controllers;

      for (var i = 0; i < controllers.length; i += 2) {
        String ingredient = controllers[i].text;
        String weight = controllers[i + 1].text;

        ingredients.add({
          'ingredient': ingredient,
          'weight': weight,
        });
      }
      print(state.formSubmissionStatus);

      try {
        await recipeRepository.saveRecipe(
          name: state.recipeName,
          serves: state.recipeServes,
          cookingTime: state.recipeCookingtime,
          category: state.recipeCatagory,
          description: state.recipeDescription,
          ingredients: ingredients,
          image: state.image,
        );
        emit(state.copyWith(formSubmissionStatus: SubmissionSuccess()));
      } catch (e) {
        if (e is Exception) {
          emit(state.copyWith(formSubmissionStatus: SubmissionFailed(e)));
        } else {
          emit(state.copyWith(
              formSubmissionStatus:
                  SubmissionFailed(Exception('An error occurred'))));
        }
      }
      if (state.formSubmissionStatus is SubmissionSuccess) {
        print("am her------");
      }
    });
  }

  @override
  Future<void> close() {
    for (var controller in state.controllers) {
      controller.dispose();
    }
    return super.close();
  }
}
