import 'package:flutter/foundation.dart';

enum Category { breakfast, lunch, dinner, snack, dessert, other }

class Recipe {
  final String name;
  final String description;
  final int cookTime;
  final int people;
  final List<String> ingredients;
  final List<String> steps;
  final bool fasting;
  final Category type;
  final String image;
  final String? cookId;
  final String? id;

  Recipe({
    required this.name,
    required this.description,
    required this.cookTime,
    required this.people,
    required this.ingredients,
    required this.steps,
    required this.fasting,
    required this.type,
    required this.image,
    this.cookId,
    required this.id,
  });
  // Getters
  String get getName => this.name;
  String get getDescription => this.description;
  int get getCookTime => this.cookTime;
  int get getPeople => this.people;
  List<String> get getIngredients => this.ingredients;
  List<String> get getSteps => this.steps;
  bool get isFasting => this.fasting;
  Category get getType => this.type;
  String get getImage => this.image;
  String? get getCookId => this.cookId;
  String? get getId => this.id;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      cookTime: json['cookTime'],
      people: json['people'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      fasting: json['fasting'],
      type: Category.values.firstWhere((e) => describeEnum(e) == json['type']),
      image: json['image'],
      cookId: json['cook_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cookTime': cookTime,
      'people': people,
      'ingredients': ingredients,
      'steps': steps,
      'fasting': fasting,
      'type': describeEnum(type),
      'image': image,
      'cook_id': cookId,
    };
  }

  factory Recipe.empty() {
    return Recipe(
      id: '0',
      name: '',
      description: '',
      cookTime: 0,
      people: 0,
      ingredients: [],
      steps: [],
      fasting: false,
      type: Category.breakfast,
      image: '',
    );
  }

  Recipe copywith({
    String? name,
    String? description,
    int? cookTime,
    int? people,
    List<String>? ingredients,
    List<String>? steps,
    bool? fasting,
    Category? type,
    String? image,
    String? cookId,
  }) {
    return Recipe(
      id: '0',
      name: name ?? this.name,
      description: description ?? this.description,
      cookTime: cookTime ?? this.cookTime,
      people: people ?? this.people,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      fasting: fasting ?? this.fasting,
      type: type ?? this.type,
      image: image ?? this.image,
      cookId: cookId ?? this.cookId,
    );
  }
}
