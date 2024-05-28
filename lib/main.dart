import 'package:firfir_tera/Repository/authRepository.dart';
import 'package:firfir_tera/Repository/profileRrepository.dart';
import 'package:firfir_tera/Repository/userRepositery.dart';
import 'package:firfir_tera/Repository/recipe_repositery.dart';
import 'package:firfir_tera/Route/route.dart';
import 'package:firfir_tera/bloc/admin/admin_bloc.dart';
import 'package:firfir_tera/bloc/admin/admin_event.dart';
import 'package:firfir_tera/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/bloc/auth/auth_even.dart';
import 'package:firfir_tera/bloc/createRecipe/create_recipe_bloc.dart';
import 'package:firfir_tera/bloc/signup/register3/register3_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<RecipeRepository>(
          create: (context) => RecipeRepository(),
        ),
        RepositoryProvider<ProfileRepository>(
            create: (context) => ProfileRepository()),
        RepositoryProvider(
          create: (context) => AuthRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CreateRecipeBloc>(
            create: (context) => CreateRecipeBloc(
                recipeRepository: context.read<RecipeRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                AdminBloc(userRepository: context.read<UserRepository>())
                  ..add(LoadUsers()),
          ),
          BlocProvider(
            create: (context) => AuthBloc()..add(AppStarted()),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => Register3Bloc(
              userRepo: context.read<UserRepository>(),
              authRepo: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
              textTheme:
                  GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme)),
          routerConfig: route,
        ),
      ),
    );
  }
}
