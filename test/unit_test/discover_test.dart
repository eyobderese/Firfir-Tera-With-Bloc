import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/recipe_repositery.dart';
import 'package:firfir_tera/application/bloc/discover/discover_bloc.dart';
import 'package:firfir_tera/presentation/pages/dicovery/bloc/discover_event.dart';
import 'package:firfir_tera/presentation/pages/dicovery/bloc/discover_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/discover_bloc_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  final mockRecipes = [
    Recipe(
      name: "recipeName",
      description: "recipeDescription",
      cookTime: 30,
      people: 4,
      ingredients: ["ingredient1", "ingredient2"],
      steps: ["step1", "step2"],
      fasting: "fasting",
      type: Category.Breakfast,
      image: "imagePath",
      id: "recipeId",
    ),
    Recipe(
      name: "recipeName2",
      description: "recipeDescription",
      cookTime: 45,
      people: 6,
      ingredients: ["ingredients"],
      steps: ["steps"],
      fasting: "fasting",
      type: Category.Lunch,
      image: "imagePath",
      id: "recipeId",
    )
  ];

  group('RecipeRepo', () {
    late DiscoverBloc discoverBloc;
    late MockRecipeRepository mockRecipeRepository;

    setUp(() {
      mockRecipeRepository = MockRecipeRepository();
      discoverBloc = DiscoverBloc(recipeRepository: mockRecipeRepository);
    });

    test('testing recipe adding ', () {
      expect(discoverBloc.state, isA<DiscoverInitial>());
    });

    blocTest<DiscoverBloc, DiscoverState>(
      'testing recipe adding',
      build: () {
        when(mockRecipeRepository.fetchRecipes(any, any))
            .thenAnswer((_) async => mockRecipes);
        return discoverBloc;
      },
      act: (bloc) => bloc.add(QuerySummited()),
      expect: () => [
        isA<DiscoverLoading>(),
        isA<DiscoverLoaded>()
            .having((state) => state.getRecipes, 'recipes', mockRecipes),
      ],
    );

    blocTest<DiscoverBloc, DiscoverState>('recipe create',
        build: () {
          when(mockRecipeRepository.fetchRecipes(any, any))
              .thenThrow(Exception('Failed to fetch recipes'));
          return discoverBloc;
        },
        act: (bloc) => bloc.add(QuerySummited()),
        expect: () => [
              isA<DiscoverLoading>(),
              isA<DiscoverError>(),
              isA<DiscoverInitial>(),
            ]);

    blocTest<DiscoverBloc, DiscoverState>(
      'recipe eddit',
      build: () {
        when(mockRecipeRepository.fetchRecipes(any, any))
            .thenAnswer((_) async => mockRecipes);
        return discoverBloc;
      },
      act: (bloc) => bloc.add(FilterChanged(filter: 'Breakfast')),
      expect: () => [
        isA<DiscoverLoading>(),
        isA<DiscoverLoaded>()
            .having((state) => state.filtter, 'filter', 'Breakfast')
            .having((state) => state.getRecipes, 'recipes', mockRecipes),
      ],
    );

    blocTest<DiscoverBloc, DiscoverState>(
      'recipe delete',
      build: () => discoverBloc,
      act: (bloc) => bloc.add(SearchQueryChanged(query: 'chicken')),
      expect: () => [
        isA<DiscoverState>().having((state) => state.query, 'query', 'chicken'),
      ],
    );
  });
}
