import 'package:firfir_tera/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          // If the user is authenticated, navigate to the home page
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            print("am here");
            context.go('/home');
          });
        } else {
          // If the user is not authenticated, navigate to the login page
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            print("am here... not autoneticated");
            context.go('/onboarding_1');
          });
        }
        // While deciding where to go, show a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}
