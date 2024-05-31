import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';
import 'package:firfir_tera/application/bloc/signup/register1/register1_bloc.dart';
import 'package:firfir_tera/presentation/pages/signUp/screen/register_1.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  testWidgets('Register_1 widget should show', (WidgetTester tester) async {
    // Arrange
    final userRepository =
        UserRepository(); // replace with your actual UserRepository initialization

    // Act
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => userRepository,
          ),
          BlocProvider<Register1Bloc>(
            create: (context) =>
                Register1Bloc(userRepo: context.read<UserRepository>()),
          ),
        ],
        child: MaterialApp(
          home: Register_1(),
        ),
      ),
    );

    // Assert
    expect(find.byType(Register_1), findsOneWidget);
  });
}
