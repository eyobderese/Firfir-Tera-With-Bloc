// create_recipe_screen.dart

import 'dart:io';
import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_bloc.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_event.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_state.dart';
import 'package:firfir_tera/presentation/screens/discover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// TODO create controllers for every field and try to collect the value and add an event form submited event when save button clicked
class CreateRecipe extends StatelessWidget {
  const CreateRecipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<CreateRecipeBloc, CreateRecipeState>(
            listener: (context, state) => {
              if (state.formSubmissionStatus is SubmissionSuccess)
                {
                  context.goNamed("/home"),
                }
              else if (state.formSubmissionStatus is FormSubmitting)
                {
                  const Center(child: CircularProgressIndicator()),
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
              if (state.formSubmissionStatus is FormSubmitting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.goNamed("/home");
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Create Recipe',
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
                                      child: Image.asset(
                                          'assets/images/placeholder.png',
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
                                icon: const Icon(Icons.edit,
                                    color: Colors.orange),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (builder) =>
                                          bottomSheet(context));
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        context
                            .read<CreateRecipeBloc>()
                            .add(RecipeNameChanged(name: value));
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        prefixIcon: const Icon(Icons.local_dining,
                            color: Colors.orange),
                        prefixText: "Recipe Name    ",
                        prefixStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Recipe Name",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) => context
                          .read<CreateRecipeBloc>()
                          .add(RecipeServesChanged(serves: value)),
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.orange),
                        prefixText: "Serves    ",
                        prefixStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Number of Serves",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) => context
                          .read<CreateRecipeBloc>()
                          .add(RecipeCookingTimeChanged(cookingTime: value)),
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        prefixIcon:
                            const Icon(Icons.access_time, color: Colors.orange),
                        prefixText: "Cooking Time    ",
                        prefixStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Cooking Time in Minutes",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Ingredients",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
                      builder: (context, state) {
                        return ListView.separated(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: state.controllers.length ~/ 2,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: buildTextField(
                                      state.controllers[index * 2],
                                      'Ingredient ${index + 1}'),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 2,
                                  child: buildTextField(
                                      state.controllers[index * 2 + 1],
                                      'weight'),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: () => context
                                      .read<CreateRecipeBloc>()
                                      .add(RemoveLine(index * 2)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CreateRecipeBloc>().add(AddLine());
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
                    ),
                    _SaveButton(),
                  ],
                );
              }
            }),
          ),
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
                context.read<CreateRecipeBloc>().add(SubmitRecipe());
                // add an event that triger the for is summited
              },
              child: const Text('Save My Recipe'));
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
