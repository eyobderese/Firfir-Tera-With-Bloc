import 'package:firfir_tera/application/bloc/discover/discover_bloc.dart';
import 'package:firfir_tera/presentation/pages/dicovery/bloc/discover_event.dart';
import 'package:firfir_tera/presentation/pages/dicovery/bloc/discover_state.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/recipe_repositery.dart';
import 'package:firfir_tera/presentation/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Discover extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BlocProvider(
            lazy: false,
            create: (context) => DiscoverBloc(
              recipeRepository: context.read<RecipeRepository>(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text("Search", style: GoogleFonts.dancingScript(fontSize: 30)),
                Text("for Recipes", style: GoogleFonts.firaSans(fontSize: 40)),
                const SizedBox(height: 20),
                SearchFormField(_searchController),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 20,
                  children: [
                    buildOptionButton("All", "food"),
                    buildOptionButton("Breakfast", "breakfast"),
                    buildOptionButton("Lunch", "lunch"),
                    buildOptionButton("Dinner", "dinner"),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Trending",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 280,
                  child: BlocListener<DiscoverBloc, DiscoverState>(
                    listener: (context, state) {
                      if (state is DiscoverError) {
                        _showSnackBar(context, state.message);
                      } else if (state is DiscoverLoading) {
                        _showSnackBar(context, "Recipes Loading...");
                      }
                    },
                    child: BlocBuilder<DiscoverBloc, DiscoverState>(
                      builder: (context, state) => state is DiscoverLoaded ||
                              state is DiscoverInitial
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.getRecipes.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: RecipeCard(
                                    recipe: state.getRecipes[index],
                                  ),
                                );
                              },
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOptionButton(String option, String iconName) {
    Map<String, String> iconMap = {
      "food": "assets/icons/all_food.png",
      "breakfast": "assets/icons/breakfast.png",
      "lunch": "assets/icons/lunch.png",
      "dinner": "assets/icons/dinner.png"
    };

    String iconPath = iconMap[iconName] ?? '';

    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) => InkWell(
        onTap: () {
          context.read<DiscoverBloc>().add(FilterChanged(filter: option));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color:
                state.filtter == option ? Colors.grey[200] : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Image.asset(
                iconPath,
                width: 30,
                height: 30,
              ),
              Text(
                option,
                style: TextStyle(
                  fontSize: state.filtter == option ? 18 : 16,
                  fontWeight: state.filtter == option
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: state.filtter == option ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Widget SearchFormField(TextEditingController searchController) {
  return BlocBuilder<DiscoverBloc, DiscoverState>(builder: (context, state) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "recipe name",
        prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              context.read<DiscoverBloc>().add(QuerySummited());
            }),
        suffixIcon: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            searchController.clear();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onChanged: (val) {
        context.read<DiscoverBloc>().add(SearchQueryChanged(query: val));
      },
      onSubmitted: (val) {
        context.read<DiscoverBloc>().add(QuerySummited());
      },
    );
  });
}
