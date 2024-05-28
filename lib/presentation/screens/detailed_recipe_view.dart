import 'package:firfir_tera/Repository/recipe_repositery.dart';
import 'package:firfir_tera/model/recipe.dart';
import 'package:firfir_tera/presentation/screens/comment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailedView extends StatelessWidget {
  final Recipe recipe;
  final RecipeRepository _recipeRepository = RecipeRepository();
  DetailedView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.goNamed("/home");
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  Text(recipe.name, //recipe name
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CommentScreen(recipeId: recipe.id!),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.comment),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.go('/edit_recipe_view',
                                        extra: recipe);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      final confirm = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Confirm'),
                                          content: const Text(
                                              'Are you sure you want to delete this recipe?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text('Yes'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: Text('No'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm) {
                                        // Send the delete request
                                        // Replace this with your actual delete request code
                                        try {
                                          await _recipeRepository
                                              .deleteRecipe(recipe.id!);
                                          context.goNamed("/home");
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Failed to delete recipe: $e'),
                                          ));
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 260,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: recipe.image.startsWith('http')
                                      ? NetworkImage(recipe.image)
                                      : AssetImage(recipe.image)
                                          as ImageProvider,
                                  fit: BoxFit.cover // recipe image
                                  ),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.timer),
                                Text('${recipe.cookTime} min' //cookTime
                                    )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.star),
                                Text("8.5 rate" //rating
                                    )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.food_bank),
                                Text(recipe.fasting),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: recipe.ingredients.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                recipe.ingredients[index],
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Steps",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: recipe.steps.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                recipe.steps[index],
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }
}
