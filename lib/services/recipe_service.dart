import 'dart:convert';
import 'dart:io';
import 'package:firfir_tera/Repository/recipe_repositery.dart';
import 'package:firfir_tera/services/authService.dart';
import 'package:http/http.dart' as http;
import 'package:firfir_tera/model/recipe.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class RecipeService {
  Future<List<Recipe>> fetchRecipes(String query, String filter) async {
    // Implement the logic to fetch recipes based on query and filter
    // For demonstration, returning an empty list
    await Future.delayed(const Duration(seconds: 3));
    return recipeList;
  }

  Future<String> uploadRecipe({
    required String name,
    required String serves,
    required String cookingTime,
    required String description,
    required String category,
    required List<Map<String, String>> ingredients,
    XFile? image,
    required String cookId,
    required String token,
  }) async {
    var uri = Uri.parse('http://10.0.2.2:3000/recipes/new');
    var request = http.MultipartRequest('POST', uri);

    // final userId = await AuthService().getUserId();

    // Add text fields
    request.headers['Authorization'] =
        'Bearer $token'; // adding token to your request
    request.fields['name'] = name;
    request.fields['people'] = serves;
    request.fields['cookTime'] = cookingTime;
    request.fields['description'] = description;
    request.fields['type'] = category;
    request.fields['fasting'] = "false"; // Hardcoded for now
    request.fields['cook_id'] =
        cookId; //TODO change the hardcoded with userId from AuthService
    // Add ingredients as JSON string
    request.fields['ingredients'] = jsonEncode(ingredients);
    request.fields['steps'] = jsonEncode([
      'Mix the dry ingredients.',
      'Add the wet ingredients and mix until smooth.',
      'Cook on a hot griddle until golden brown.'
    ]);

    File imageFile = File(image!.path);

    String extension = path.extension(imageFile.path).toLowerCase();
    if (extension != '.jpg' && extension != '.png') {
      throw Exception('The image file must be a jpg or png file');
    }
    // Add image file

    var stream = http.ByteStream(image.openRead());
    var length = await image.length();
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: path.basename(imageFile.path),
        contentType: MediaType('image', extension.substring(1)));
    request.files.add(multipartFile);

    // Send the request
    var response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 201) {
      return ('Recipe uploaded successfully');
    } else {
      throw Exception(
          'Failed to upload recipe Status code: ${response.statusCode}');
    }
  }

  // create a method that fetches recipes using keyword for search and category for filter,

  Future<List<Recipe>> searchRecipes(String query, String filter) async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:3000/recipes/query?keyword=$query&category=$filter'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }
}

// final List<Recipe> recipeList = [
//   Recipe(
//     name: 'Pancakes',
//     description: 'Fluffy and delicious pancakes perfect for breakfast.',
//     cookTime: 20,
//     people: 4,
//     ingredients: ['Flour', 'Milk', 'Eggs', 'Baking Powder', 'Sugar', 'Salt'],
//     steps: [
//       'Mix the dry ingredients.',
//       'Add the wet ingredients and mix until smooth.',
//       'Cook on a hot griddle until golden brown.'
//     ],
//     fasting: false,
//     type: Category.breakfast,
//     image: 'assets/images/beyaynet_fisik.jpg',
//     cookId: 'cook1',
//   ),
//   Recipe(
//     name: 'Spaghetti Carbonara',
//     description: 'Classic Italian pasta dish with a creamy egg-based sauce.',
//     cookTime: 30,
//     people: 2,
//     ingredients: ['Spaghetti', 'Eggs', 'Pancetta', 'Parmesan Cheese', 'Pepper'],
//     steps: [
//       'Cook the spaghetti until al dente.',
//       'Fry the pancetta until crispy.',
//       'Mix the eggs and cheese together.',
//       'Combine everything with the cooked spaghetti.'
//     ],
//     fasting: false,
//     type: Category.lunch,
//     image: 'assets/images/kikil.jpg',
//     cookId: 'cook2',
//   ),
//   Recipe(
//     name: 'Chicken Curry',
//     description: 'Spicy and flavorful chicken curry perfect for dinner.',
//     cookTime: 45,
//     people: 4,
//     ingredients: [
//       'Chicken',
//       'Onions',
//       'Garlic',
//       'Ginger',
//       'Tomatoes',
//       'Spices',
//       'Coconut Milk'
//     ],
//     steps: [
//       'Saute onions, garlic, and ginger.',
//       'Add the chicken and spices.',
//       'Add tomatoes and cook until soft.',
//       'Add coconut milk and simmer until chicken is cooked.'
//     ],
//     fasting: false,
//     type: Category.dinner,
//     image: 'assets/images/sambusa.jpg',
//     cookId: 'cook3',
//   ),
//   Recipe(
//     name: 'Chocolate Cake',
//     description: 'Rich and moist chocolate cake perfect for dessert.',
//     cookTime: 60,
//     people: 8,
//     ingredients: [
//       'Flour',
//       'Cocoa Powder',
//       'Sugar',
//       'Eggs',
//       'Butter',
//       'Baking Powder',
//       'Milk'
//     ],
//     steps: [
//       'Mix the dry ingredients.',
//       'Add the wet ingredients and mix until smooth.',
//       'Pour into a baking pan and bake until done.'
//     ],
//     fasting: false,
//     type: Category.dessert,
//     image: 'assets/images/shiro.webp',
//     cookId: 'cook4',
//   ),
//   Recipe(
//     name: 'Fruit Salad',
//     description: 'A refreshing mix of seasonal fruits.',
//     cookTime: 10,
//     people: 4,
//     ingredients: ['Apples', 'Bananas', 'Grapes', 'Oranges', 'Berries'],
//     steps: [
//       'Wash and chop all the fruits.',
//       'Mix them together in a large bowl.',
//       'Serve immediately or chilled.'
//     ],
//     fasting: true,
//     type: Category.snack,
//     image: 'assets/images/Tegabino.png',
//     cookId: 'cook5',
//   ),
// ];
