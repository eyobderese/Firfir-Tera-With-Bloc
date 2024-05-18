import 'package:firfir_tera/model/recipe.dart';

class RecipeRepository {
  Future<List<Recipe>> fetchRecipes(String query, String filter) async {
    // Implement the logic to fetch recipes based on query and filter
    // For demonstration, returning an empty list
    await Future.delayed(const Duration(seconds: 3));
    return recipeList;
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
