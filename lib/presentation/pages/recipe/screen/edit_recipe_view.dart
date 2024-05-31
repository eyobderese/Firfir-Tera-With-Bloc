// I want to have all the ui in create_recipe_view.dart and when I click on the edit button in detailed_recipe_view.dart I want to navigate to the edit_recipe_view and the field's have the data from the recipe that I clicked on in detailed_recipe_view.dart
// I want to have all the ui in create_recipe_view.dart and when I click on the edit button in detailed_recipe_view.dart I want to navigate to the edit_recipe_view and the field's have the data from the recipe that I clicked on in detailed_recipe_view.dart

// Path: lib/presentation/screens/edit_recipe_view.dart

// create_recipe_screen.dart

import 'dart:io';
import 'package:firfir_tera/application/bloc/Home/home_bloc.dart';
import 'package:firfir_tera/presentation/pages/home/bloc/home_event.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/application/bloc/createRecipe/create_recipe_bloc.dart';
import 'package:firfir_tera/presentation/pages/recipe/bloc/create_recipe_event.dart';
import 'package:firfir_tera/presentation/pages/recipe/bloc/create_recipe_state.dart';
import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:firfir_tera/presentation/pages/recipe/screen/detailed_recipe_view.dart';
import 'package:firfir_tera/presentation/widgets/fasting_drop_down.dart';
import 'package:firfir_tera/presentation/widgets/meal_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// TODO create controllers for every field and try to collect the value and add an event form submited event when save button clicked
class EditRecipe extends StatefulWidget {
  final Recipe recipe;
  const EditRecipe({Key? key, required this.recipe}) : super(key: key);

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController serveController = TextEditingController();
  final TextEditingController cookTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<CreateRecipeBloc>()
        .add(LoadRecipeForEditing(recipe: widget.recipe));
    recipeNameController.text = widget.recipe.name;
    serveController.text = widget.recipe.people.toString();
    cookTimeController.text = widget.recipe.cookTime.toString();
    descriptionController.text = widget.recipe.description;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final ScrollController _scrollController1 = ScrollController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<CreateRecipeBloc, CreateRecipeState>(
            listener: (context, state) => {
              if (state.formSubmissionStatus is SubmissionSuccess)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recipe edited Successfully')),
                  ),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailedView(recipeId: widget.recipe.id!),
                    ),
                  )
                }
              else if (state.formSubmissionStatus is SubmissionFailed)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          (state.formSubmissionStatus as SubmissionFailed)
                              .exception
                              .toString()),
                    ),
                  ),
                }
            },
            child: BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
                builder: (context, state) {
              return ListView(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailedView(recipeId: widget.recipe.id!),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text('Edit Recipe',
                      style: GoogleFonts.firaSans(fontSize: 40)),
                  const SizedBox(height: 20),
                  BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: state.image == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(widget.recipe.image,
                                        fit: BoxFit.cover),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(File(state.image!.path),
                                        fit: BoxFit.cover),
                                  ),
                          ),
                          Positioned(
                            top: 10,
                            right: 20,
                            child: IconButton(
                              icon:
                                  const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (builder) => bottomSheet(context));
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  recipeNameField(context, recipeNameController),
                  const SizedBox(height: 20),
                  serveField(context, serveController),
                  const SizedBox(height: 20),
                  cockTimeField(context, cookTimeController),
                  const SizedBox(height: 20),
                  description(context, descriptionController),
                  const SizedBox(height: 20),
                  MealTypeDropdown(),
                  const SizedBox(height: 20),
                  FastingDropdown(),
                  const SizedBox(height: 20),
                  const Text("Ingredients",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _ingridentFeilds(_scrollController),
                  _addLineIngrident(context),
                  const SizedBox(height: 20),
                  const Text("Steps",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _stepFeilds(_scrollController1),
                  _addLineStep(context),
                  _SaveButton(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  BlocBuilder<CreateRecipeBloc, CreateRecipeState> _ingridentFeilds(
      ScrollController _scrollController) {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.ingredientControllers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: buildTextField(state.ingredientControllers[index],
                      'Ingredient ${index + 1}'),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () => context
                      .read<CreateRecipeBloc>()
                      .add(RemoveLineIngrident(index)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  GestureDetector _addLineIngrident(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CreateRecipeBloc>().add(AddLineIngrident());
      },
      child: const Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(width: 8),
          Text(
            "Add Ingredient",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  BlocBuilder<CreateRecipeBloc, CreateRecipeState> _stepFeilds(
      ScrollController _scrollController) {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.stepControllers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: buildTextField(
                      state.stepControllers[index], 'Step ${index + 1}'),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () => context
                      .read<CreateRecipeBloc>()
                      .add(RemoveLineStep(index)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  GestureDetector _addLineStep(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CreateRecipeBloc>().add(AddLineStep());
      },
      child: const Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(width: 8),
          Text(
            "Add Step",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  TextField cockTimeField(
      BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      onChanged: (value) => context
          .read<CreateRecipeBloc>()
          .add(RecipeCookingTimeChanged(cookingTime: value)),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: const Icon(Icons.access_time, color: Colors.orange),
        prefixText: "Cooking Time    ",
        prefixStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        hintText: "Enter Cooking Time in Minutes",
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  TextField serveField(BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: (value) => context
          .read<CreateRecipeBloc>()
          .add(RecipeServesChanged(serves: value)),
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: const Icon(Icons.person, color: Colors.orange),
        prefixText: "Serves    ",
        prefixStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        hintText: "Enter Number of Serves",
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  TextField recipeNameField(
      BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.end,
      onChanged: (value) {
        context.read<CreateRecipeBloc>().add(RecipeNameChanged(name: value));
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: const Icon(Icons.local_dining, color: Colors.orange),
        prefixText: "Recipe Name    ",
        prefixStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        hintText: "Enter Recipe Name",
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  TextField description(
      BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      onChanged: (value) => context
          .read<CreateRecipeBloc>()
          .add(RecipeDescriptionChanged(recipeDescription: value)),
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: const Icon(Icons.edit, color: Colors.orange),
        prefixText: "description    ",
        prefixStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        hintText: "Enter Recipe discription",
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _SaveButton() {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
        builder: (context, state) {
      return state.formSubmissionStatus is FormSubmitting
          ? const LinearProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context
                    .read<CreateRecipeBloc>()
                    .add(UpdateRecipe(recipeId: widget.recipe.id.toString()));
                // add an event that triger the for is summited
              },
              child: const Text('Update My Recipe'));
    });
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Choose Image', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  context
                      .read<CreateRecipeBloc>()
                      .add(const PickImage(ImageSource.camera));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  context
                      .read<CreateRecipeBloc>()
                      .add(const PickImage(ImageSource.gallery));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
