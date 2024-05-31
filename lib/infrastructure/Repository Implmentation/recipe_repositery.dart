import 'package:firfir_tera/infrastructure/services/recipe_service.dart';
import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:firfir_tera/infrastructure/services/authService.dart';
import 'package:image_picker/image_picker.dart';

class RecipeRepositoryImp {
  final AuthService _authService = AuthService();
  final RecipeService _recipeService = RecipeService();

  Future<List<Recipe>> fetchRecipes(String query, String filter) async {
    final List<Recipe> recipeList =
        await _recipeService.searchRecipes(query, filter);
    print(recipeList);
    return recipeList;
  }

  Future<Recipe> fetchRecipe(String recipeId) async {
    final Recipe recipe = await _recipeService.getRecipe(recipeId);

    return recipe;
  }

  Future<String> saveRecipe({
    required String name,
    required String serves,
    required String cookingTime,
    required String description,
    required String category,
    required String fasting,
    required List<String> ingredients,
    required List<String> steps,
    XFile? image,
  }) async {
    final token = await _authService.getToken();
    final cookId = await _authService.getUserId();
    print(cookId);

    try {
      final response = await _recipeService.uploadRecipe(
        name: name,
        serves: serves,
        cookingTime: cookingTime,
        description: description,
        category: category,
        fasting: fasting,
        ingredients: ingredients,
        steps: steps,
        image: image,
        cookId: cookId!,
        token: token!,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> updateRecipe({
    required String name,
    required String serves,
    required String cookingTime,
    required String description,
    required String category,
    required String fasting,
    required List<String> ingredients,
    required List<String> steps,
    required String recipeId,
    XFile? image,
  }) async {
    final token = await _authService.getToken();
    final cookId = await _authService.getUserId();
    print(cookId);

    try {
      final response = await _recipeService.updateRecipe(
        name: name,
        serves: serves,
        cookingTime: cookingTime,
        description: description,
        category: category,
        fasting: fasting,
        ingredients: ingredients,
        steps: steps,
        image: image,
        cookId: cookId!,
        token: token!,
        recipeId: recipeId,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> deleteRecipe(String recipeId) async {
    final token = await _authService.getToken();
    try {
      final response = await _recipeService.deleteRecipe(recipeId, token!);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}

final List<Recipe> recipeList = [
  Recipe(
    id: '1',
    name: 'Pancakes',
    description: 'Fluffy and delicious pancakes perfect for breakfast.',
    cookTime: 20,
    people: 4,
    ingredients: ['Flour', 'Milk', 'Eggs', 'Baking Powder', 'Sugar', 'Salt'],
    steps: [
      'Mix the dry ingredients.',
      'Add the wet ingredients and mix until smooth.',
      'Cook on a hot griddle until golden brown.'
    ],
    fasting: "Non-Fasting",
    type: Category.Breakfast,
    image: "http://10.0.2.2:3000/uploads/1716673118683.jpg",
    cookId: 'cook1',
  ),
  Recipe(
    id: '1',
    name: 'Spaghetti Carbonara',
    description: 'Classic Italian pasta dish with a creamy egg-based sauce.',
    cookTime: 30,
    people: 2,
    ingredients: ['Spaghetti', 'Eggs', 'Pancetta', 'Parmesan Cheese', 'Pepper'],
    steps: [
      'Cook the spaghetti until al dente.',
      'Fry the pancetta until crispy.',
      'Mix the eggs and cheese together.',
      'Combine everything with the cooked spaghetti.'
    ],
    fasting: "Non-Fasting",
    type: Category.Lunch,
    image: 'assets/images/kikil.jpg',
    cookId: 'cook2',
  ),
  Recipe(
    id: '1',
    name: 'Chicken Curry',
    description: 'Spicy and flavorful chicken curry perfect for dinner.',
    cookTime: 45,
    people: 4,
    ingredients: [
      'Chicken',
      'Onions',
      'Garlic',
      'Ginger',
      'Tomatoes',
      'Spices',
      'Coconut Milk'
    ],
    steps: [
      'Saute onions, garlic, and ginger.',
      'Add the chicken and spices.',
      'Add tomatoes and cook until soft.',
      'Add coconut milk and simmer until chicken is cooked.'
    ],
    fasting: "Non-Fasting",
    type: Category.Dinner,
    image: 'assets/images/sambusa.jpg',
    cookId: 'cook3',
  ),
  Recipe(
    id: '1',
    name: 'Chocolate Cake',
    description: 'Rich and moist chocolate cake perfect for dessert.',
    cookTime: 60,
    people: 8,
    ingredients: [
      'Flour',
      'Cocoa Powder',
      'Sugar',
      'Eggs',
      'Butter',
      'Baking Powder',
      'Milk'
    ],
    steps: [
      'Mix the dry ingredients.',
      'Add the wet ingredients and mix until smooth.',
      'Pour into a baking pan and bake until done.'
    ],
    fasting: "Non-Fasting",
    type: Category.Dinner,
    image: 'assets/images/shiro.webp',
    cookId: 'cook4',
  ),
  Recipe(
    id: '1',
    name: 'Fruit Salad',
    description: 'A refreshing mix of seasonal fruits.',
    cookTime: 10,
    people: 4,
    ingredients: ['Apples', 'Bananas', 'Grapes', 'Oranges', 'Berries'],
    steps: [
      'Wash and chop all the fruits.',
      'Mix them together in a large bowl.',
      'Serve immediately or chilled.'
    ],
    fasting: "Fasting",
    type: Category.Snack,
    image: 'assets/images/Tegabino.png',
    cookId: 'cook5',
  ),
];
