import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Recipe', () {
    final recipe = Recipe(
      name: 'Spaghetti',
      description: 'A classic Italian dish',
      cookTime: 30,
      people: 4,
      ingredients: ['Spaghetti', 'Tomato Sauce', 'Cheese'],
      steps: ['Boil water', 'Cook pasta', 'Serve with sauce and cheese'],
      fasting: 'Non-Fasting',
      type: Category.Dinner,
      image: 'image.png',
      cookId: 'cook123',
      id: 'recipe123',
    );

    test('fromJson creates correct instance', () {
      final json = {
        'name': 'Spaghetti',
        'description': 'A classic Italian dish',
        'cookTime': 30,
        'people': 4,
        'ingredients': ['Spaghetti', 'Tomato Sauce', 'Cheese'],
        'steps': ['Boil water', 'Cook pasta', 'Serve with sauce and cheese'],
        'fasting': 'Non-Fasting',
        'type': 'Dinner',
        'image': 'image.png',
        'cook_id': 'cook123',
        '_id': 'recipe123',
      };

      final recipeFromJson = Recipe.fromJson(json);

      expect(recipeFromJson.name, 'Spaghetti');
      expect(recipeFromJson.description, 'A classic Italian dish');
      expect(recipeFromJson.cookTime, 30);
      expect(recipeFromJson.people, 4);
      expect(
          recipeFromJson.ingredients, ['Spaghetti', 'Tomato Sauce', 'Cheese']);
      expect(recipeFromJson.steps,
          ['Boil water', 'Cook pasta', 'Serve with sauce and cheese']);
      expect(recipeFromJson.fasting, 'Non-Fasting');
      expect(recipeFromJson.type, Category.Breakfast);
      expect(recipeFromJson.image, 'image.png');
      expect(recipeFromJson.cookId, 'cook123');
      expect(recipeFromJson.id, 'recipe123');
    });

    test('toJson returns correct map', () {
      final json = recipe.toJson();

      expect(json, {
        'name': 'Spaghetti',
        'description': 'A classic Italian dish',
        'cookTime': 30,
        'people': 4,
        'ingredients': ['Spaghetti', 'Tomato Sauce', 'Cheese'],
        'steps': ['Boil water', 'Cook pasta', 'Serve with sauce and cheese'],
        'fasting': 'Non-Fasting',
        'type': 'Dinner',
        'image': 'image.png',
        'cook_id': 'cook123',
      });
    });

    test('getters return correct values', () {
      expect(recipe.getName, 'Spaghetti');
      expect(recipe.getDescription, 'A classic Italian dish');
      expect(recipe.getCookTime, 30);
      expect(recipe.getPeople, 4);
      expect(recipe.getIngredients, ['Spaghetti', 'Tomato Sauce', 'Cheese']);
      expect(recipe.getSteps,
          ['Boil water', 'Cook pasta', 'Serve with sauce and cheese']);
      expect(recipe.isFasting, 'Non-Fasting');
      expect(recipe.getType, Category.Dinner);
      expect(recipe.getImage, 'image.png');
      expect(recipe.getCookId, 'cook123');
      expect(recipe.getId, 'recipe123');
    });

    test('empty factory creates correct instance', () {
      final emptyRecipe = Recipe.empty();

      expect(emptyRecipe.id, '0');
      expect(emptyRecipe.name, '');
      expect(emptyRecipe.description, '');
      expect(emptyRecipe.cookTime, 0);
      expect(emptyRecipe.people, 0);
      expect(emptyRecipe.ingredients, []);
      expect(emptyRecipe.steps, []);
      expect(emptyRecipe.fasting, 'Non-Fasting');
      expect(emptyRecipe.type, Category.Breakfast);
      expect(emptyRecipe.image, '');
    });

  });
}
