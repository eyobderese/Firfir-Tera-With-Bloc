import 'dart:io';
import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipeState {
  final List<TextEditingController> controllers;
  final XFile? image;
  final FormSubmissionStatus formSubmissionStatus;
  final String recipeName;
  final String recipeServes;
  final String recipeCookingtime;

  CreateRecipeState(
      {required this.controllers,
      required this.recipeName,
      required this.recipeServes,
      required this.recipeCookingtime,
      this.image,
      required this.formSubmissionStatus});

  CreateRecipeState copyWith(
      {List<TextEditingController>? controllers,
      XFile? image,
      FormSubmissionStatus? formSubmissionStatus,
      String? recipeName,
      String? recipeServes,
      String? recipeCookingtime}) {
    return CreateRecipeState(
        controllers: controllers ?? this.controllers,
        image: image ?? this.image,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        recipeName: recipeName ?? this.recipeName,
        recipeServes: recipeServes ?? this.recipeServes,
        recipeCookingtime: recipeCookingtime ?? this.recipeCookingtime);
  }
}
