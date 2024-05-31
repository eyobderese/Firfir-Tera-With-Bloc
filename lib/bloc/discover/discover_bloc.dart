import 'package:firfir_tera/bloc/discover/discover_event.dart';
import 'package:firfir_tera/bloc/discover/discover_state.dart';
import 'package:firfir_tera/Repository/recipe_repositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final RecipeRepository recipeRepository;

  DiscoverBloc({required this.recipeRepository})
      : super(DiscoverInitial(recipeList)) {
    on<FilterChanged>((event, emit) async {
      emit(DiscoverLoading(filtter: event.filter, query: state.query));
      try {
        // state.copyWith(filtter: event.filter);
        final recipes =
            await recipeRepository.fetchRecipes(state.query, event.filter);
        emit(
            DiscoverLoaded(recipes, filtter: event.filter, query: state.query));
      } catch (e) {
        print(e.toString());
        emit(DiscoverError(e.toString()));
        emit(DiscoverInitial(recipeList));
      }
    });

    on<SearchQueryChanged>((event, emit) {
      emit(state.copyWith(query: event.query));
    });

    on<QuerySummited>((event, emit) async {
      print("Query Summited ");
      print("query is ${state.query}");

      emit(DiscoverLoading(query: state.query, filtter: state.filtter));
      try {
        final recipes =
            await recipeRepository.fetchRecipes(state.query, state.filtter);
        print(recipes);
        emit(DiscoverLoaded(recipes));
      } catch (e) {
        emit(DiscoverError(e.toString()));
        emit(DiscoverInitial(recipeList));
      }
    });
  }
}
