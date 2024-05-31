import 'package:firfir_tera/presentation/pages/comment/screen/comment.dart';
import 'package:firfir_tera/presentation/pages/recipe/screen/edit_recipe_view.dart';
import 'package:go_router/go_router.dart';
import 'package:firfir_tera/Domain/Entities/recipe.dart';
import 'package:firfir_tera/presentation/pages/admin/screen/admin.dart';
import 'package:firfir_tera/presentation/pages/recipe/screen/create_recipe_page.dart';
import 'package:firfir_tera/presentation/pages/profile/screen/edit_profile.dart';
import 'package:firfir_tera/presentation/pages/signUp/screen/register_3.dart';
import 'package:firfir_tera/presentation/pages/splash/screen/splash_screen.dart';

import 'package:firfir_tera/presentation/pages/home/screen/home.dart';
import 'package:firfir_tera/presentation/pages/signIn/screen/login.dart';
import 'package:firfir_tera/presentation/pages/signUp/screen/register_1.dart';
import 'package:firfir_tera/presentation/pages/signUp/screen/register_2.dart';

import 'package:firfir_tera/presentation/pages/recipe/screen/detailed_recipe_view.dart';
import 'package:firfir_tera/presentation/pages/onBoarding/screen/onboarding_1.dart';
import 'package:firfir_tera/presentation/pages/onBoarding/screen/onboarding_2.dart';
import 'package:firfir_tera/presentation/pages/onBoarding/screen/onboarding_3.dart';

final GoRouter route = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      name: "/",
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
        path: "/onBoarding_1",
        name: "/onBoarding_1",
        builder: (context, state) => const OnBoarding_1()),
    GoRoute(
        path: "/onboarding_2",
        name: "/onBoarding_2",
        builder: (context, state) => const OnBoarding_2()),
    GoRoute(
        path: "/onboarding_3",
        name: "/onBoarding_3",
        builder: (context, state) => const OnBoarding_3()),
    GoRoute(
        path: "/home",
        name: "/home",
        builder: (context, state) => const Home()),
    GoRoute(
        path: "/login", name: "/login", builder: (context, state) => Login()),
    GoRoute(
        path: "/register_1",
        name: "/register_1",
        builder: (context, state) => Register_1()),
    GoRoute(
        path: "/register_2",
        name: "/register_2",
        builder: (context, state) => Register_2()),
    GoRoute(
        path: "/register_3",
        name: "/register_3",
        builder: (context, state) => const Register_3()),
    GoRoute(
        path: "/detailed_recipe_view/:recipeId",
        name: "/detailed_recipe_view",
        builder: (context, state) {
          print(state.extra);
          final recipeId = state.pathParameters['recipeId'];
          print(recipeId);
          return DetailedView(
            recipeId: recipeId!,
          );
        }),
    GoRoute(
        path: "/edit_recipe_view",
        name: "/edit_recipe_view",
        builder: (context, state) {
          print(state.extra);
          final recipe = state.extra as Recipe;
          return EditRecipe(
            recipe: recipe,
          );
        }),
    GoRoute(
        path: "/admin",
        name: "/admin",
        builder: (context, state) => AdminPanel()),
    GoRoute(
        path: "/userDetail",
        name: "/userDetail",
        builder: (context, state) => AdminPanel()),
    GoRoute(
        path: "/create_recipe",
        name: "/create_recipe",
        builder: (context, state) => CreateRecipe()),
    GoRoute(
      path: "/comment/:recipeId",
      name: "/comment",
      builder: (context, state) {
        final recipeId = state.pathParameters['recipeId'];
        return CommentScreen(recipeId: recipeId!);
      },
    ),
    GoRoute(
        path: "/eddit_profile",
        name: "/edit_profile",
        builder: (context, state) => EditProfile()),
  ],
);
