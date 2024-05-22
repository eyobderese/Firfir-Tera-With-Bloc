import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateRecipeEvent extends Equatable {
  const CreateRecipeEvent();

  @override
  List<Object?> get props => [];
}

class AddLine extends CreateRecipeEvent {}

class RemoveLine extends CreateRecipeEvent {
  final int index;

  const RemoveLine(this.index);

  @override
  List<Object> get props => [index];
}

class PickImage extends CreateRecipeEvent {
  final ImageSource source;

  const PickImage(this.source);

  @override
  List<Object> get props => [source];
}

class RecipeNameChanged extends CreateRecipeEvent {
  final String name;

  const RecipeNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class RecipeServesChanged extends CreateRecipeEvent {
  final String serves;

  const RecipeServesChanged({required this.serves});

  @override
  List<Object> get props => [serves];
}

class RecipeCookingTimeChanged extends CreateRecipeEvent {
  final String cookingTime;

  const RecipeCookingTimeChanged({required this.cookingTime});

  @override
  List<Object> get props => [cookingTime];
}

class SubmitRecipe extends CreateRecipeEvent {}
