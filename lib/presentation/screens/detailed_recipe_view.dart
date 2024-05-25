import 'package:firfir_tera/model/recipe.dart';
import 'package:firfir_tera/presentation/screens/comment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailedView extends StatelessWidget {
  final Recipe recipe;
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
                                  Text(recipe.name
                                      //recipe name,
                                      ),
                                ],
                              ),
                            ),
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
                                icon: Icon(Icons.comment))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 260,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(recipe
                                      .image), //TODO here change the hard code image fiele to recipe.image
                                  fit: BoxFit.cover // recipe image
                                  ),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.timer),
                                Text("45 mins" //cookTime
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
                                Text("Fasting" //categroy
                                    )
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
