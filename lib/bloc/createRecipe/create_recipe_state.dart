import 'dart:io';
import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipeState {
  final List<TextEditingController> controllers;
  final XFile? image;
  final FormSubmissionStatus formSubmissionStatus;
  final String recipeName;
  final String recipeServes;
  final String recipeCookingtime;
  final String recipeDescription;
  final String recipeCatagory;

  CreateRecipeState(
      {required this.controllers,
      required this.recipeName,
      required this.recipeServes,
      required this.recipeCookingtime,
      this.image,
      required this.formSubmissionStatus,
      required this.recipeDescription,
      required this.recipeCatagory});

  CreateRecipeState copyWith(
      {List<TextEditingController>? controllers,
      XFile? image,
      FormSubmissionStatus? formSubmissionStatus,
      String? recipeName,
      String? recipeServes,
      String? recipeCookingtime,
      String? recipeDescription,
      String? recipeCatagory}) {
    return CreateRecipeState(
        controllers: controllers ?? this.controllers,
        image: image ?? this.image,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        recipeName: recipeName ?? this.recipeName,
        recipeServes: recipeServes ?? this.recipeServes,
        recipeCookingtime: recipeCookingtime ?? this.recipeCookingtime,
        recipeDescription: recipeDescription ?? this.recipeDescription,
        recipeCatagory: recipeCatagory ?? this.recipeCatagory);
  }
}
