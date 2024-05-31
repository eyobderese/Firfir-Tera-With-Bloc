import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';
import 'package:firfir_tera/application/bloc/signup/register2/register2_bloc.dart';
import 'package:firfir_tera/presentation/pages/signUp/screen/register_2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  testWidgets('Register_1 widget should show', (WidgetTester tester) async {
    // Arrange
    final userRepository =
        UserRepository(); 
    // Act
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => userRepository,
          ),
          BlocProvider<Register2Bloc>(
            create: (context) =>
                Register2Bloc(userRepo: context.read<UserRepository>()),
          ),
        ],
        child: MaterialApp(
          home: Register_2(),
        ),
      ),
    );

    // Assert
    expect(find.byType(Register_2), findsOneWidget);
  });
}
