import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = 250;
    final double hight = 200;

    return SizedBox(
      width: width,
      height: 100,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: () {
            context.go('/detailed_recipe_view/${recipe.id}');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: recipe.image.startsWith('http')
                    ? Image.network(
                        recipe.image,
                        height: height * 0.9,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        recipe.image,
                        height: height * 0.9,
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final int width = 200;
final int height = 250;
