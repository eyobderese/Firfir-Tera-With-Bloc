import 'package:equatable/equatable.dart';
import 'package:firfir_tera/bloc/auth/model/recipe.dart';
import 'package:firfir_tera/presentation/screens/discover.dart';

class DiscoverState extends Equatable {
  final String filtter;
  final String query;

  const DiscoverState({this.filtter = "All", this.query = ""});

  List<Recipe> get getRecipes => [];

  DiscoverState copyWith({
    String? filtter,
    String? query,
  }) {
    return DiscoverState(
      filtter: filtter ?? this.filtter,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [];
}

class DiscoverInitial extends DiscoverState {
  final List<Recipe> recipes;

  const DiscoverInitial(this.recipes);
  @override
  List<Recipe> get getRecipes => recipes;
}

class DiscoverLoading extends DiscoverState {
  final String filtter;
  final String query;

  const DiscoverLoading({this.filtter = "All", this.query = ""});
}

class DiscoverLoaded extends DiscoverState {
  final List<Recipe> recipes;
  final String filtter;
  final String query;

  const DiscoverLoaded(this.recipes, {this.filtter = "All", this.query = ""});
  @override
  List<Recipe> get getRecipes => recipes;

  @override
  List<Object> get props => [recipes];
}

class DiscoverError extends DiscoverState {
  final String message;

  const DiscoverError(this.message);

  @override
  List<Object> get props => [message];
}
