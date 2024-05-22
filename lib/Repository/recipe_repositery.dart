import 'dart:convert';

import 'package:firfir_tera/model/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class RecipeRepository {
  Future<List<Recipe>> fetchRecipes(String query, String filter) async {
    // Implement the logic to fetch recipes based on query and filter
    // For demonstration, returning an empty list
    await Future.delayed(const Duration(seconds: 3));
    return recipeList;
  }

  Future<String> saveRecipe({
    required String name,
    required String serves,
    required String cookingTime,
    required List<Map<String, String>> ingredients,
    XFile? image,
  }) async {
    var uri = Uri.parse('https://yourserver.com/api/recipes');
    var request = http.MultipartRequest('POST', uri);

    // Add text fields
    request.fields['name'] = name;
    request.fields['serves'] = serves;
    request.fields['cooking_time'] = cookingTime;

    // Add ingredients as JSON string
    request.fields['ingredients'] = jsonEncode(ingredients);

    // Add image file
    if (image != null) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: path.basename(image.path),
      );
      request.files.add(multipartFile);
    }

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      return ('Recipe uploaded successfully');
    } else {
      return ('Failed to upload recipe Status code: ${response.statusCode}');
    }
  }
}

final List<Recipe> recipeList = [
  Recipe(
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
    fasting: false,
    type: Category.breakfast,
    image: 'assets/images/beyaynet_fisik.jpg',
    cookId: 'cook1',
  ),
  Recipe(
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
    fasting: false,
    type: Category.lunch,
    image: 'assets/images/kikil.jpg',
    cookId: 'cook2',
  ),
  Recipe(
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
    fasting: false,
    type: Category.dinner,
    image: 'assets/images/sambusa.jpg',
    cookId: 'cook3',
  ),
  Recipe(
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
    fasting: false,
    type: Category.dessert,
    image: 'assets/images/shiro.webp',
    cookId: 'cook4',
  ),
  Recipe(
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
    fasting: true,
    type: Category.snack,
    image: 'assets/images/Tegabino.png',
    cookId: 'cook5',
  ),
];
