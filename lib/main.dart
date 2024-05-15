import 'package:firfir_tera/presentation/screens/admin.dart';
import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:firfir_tera/presentation/screens/register_3.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/screens/home.dart';
import 'package:firfir_tera/presentation/screens/login.dart';
import 'package:firfir_tera/presentation/screens/register_1.dart';
import 'package:firfir_tera/presentation/screens/register_2.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firfir_tera/presentation/screens/detailed_recipe_view.dart';
import 'package:firfir_tera/presentation/screens/onboarding_1.dart';
import 'package:firfir_tera/presentation/screens/onboarding_2.dart';
import 'package:firfir_tera/presentation/screens/onboarding_3.dart';

import 'presentation/screens/comment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          textTheme:
              GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme)),
      routerConfig: _route,
    );
  }
}

final GoRouter _route = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: "/",
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
        builder: (context, state) => const Register_1()),
    GoRoute(
        path: "/register_2",
        name: "/register_2",
        builder: (context, state) => const Register_2()),
    GoRoute(
        path: "/register_3",
        name: "/register_3",
        builder: (context, state) => const Register_3()),
    GoRoute(
        path: "/home/detailed_view",
        name: "/detailed_view",
        builder: (context, state) => const DetailedView()),
    GoRoute(
        path: "/admin",
        name: "/admin",
        builder: (context, state) => AdminPanel()),
    GoRoute(
        path: "/create_recipe",
        name: "/create_recipe",
        builder: (context, state) => CreateRecipe()),
    GoRoute(
        path: "/comment",
        name: "/comment",
        builder: (context, state) => CreateComment()),
  ],
);
