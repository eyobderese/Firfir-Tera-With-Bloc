import 'package:firfir_tera/Domain/Repository%20Interface/authRepository.dart';
import 'package:firfir_tera/application/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/application/bloc/login/login_bloc.dart';
import 'package:firfir_tera/presentation/pages/signIn/screen/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// replace with your actual package

void main() {
  testWidgets('Login1 widget should show', (WidgetTester tester) async {
    // Arrange
    final authRepository =
        AuthRepository(); // replace with your actual AuthRepository initialization
    final authBloc =
        AuthBloc(); // replace with your actual AuthBloc initialization

    // Act
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => authRepository,
          ),
          BlocProvider<AuthBloc>(
            create: (context) => authBloc,
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authRepo: context.read<AuthRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          home: Login1(),
        ),
      ),
    );

    // Assert
    expect(find.byType(Login1), findsOneWidget);
  });
}
