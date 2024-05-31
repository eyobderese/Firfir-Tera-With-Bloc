import 'package:firfir_tera/Domain/Repository%20Interface/authRepository.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/profileRrepository.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/recipe_repositery.dart';
import 'package:firfir_tera/presentation/Route/route.dart';
import 'package:firfir_tera/application/bloc/admin/admin_bloc.dart';
import 'package:firfir_tera/presentation/pages/admin/bloc/admin_event.dart';
import 'package:firfir_tera/application/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/application/bloc/auth/auth_even.dart';
import 'package:firfir_tera/application/bloc/comment/comment_bloc.dart';
import 'package:firfir_tera/application/bloc/createRecipe/create_recipe_bloc.dart';
import 'package:firfir_tera/application/bloc/signup/register3/register3_bloc.dart';
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
          BlocProvider(
            lazy: false,
            create: (context) => CommentBloc(),
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
