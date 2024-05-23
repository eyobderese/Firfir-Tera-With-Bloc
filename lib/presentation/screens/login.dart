import 'dart:math';

import 'package:firfir_tera/Repository/authRepository.dart';
import 'package:firfir_tera/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:firfir_tera/bloc/login/login_bloc.dart';
import 'package:firfir_tera/bloc/login/login_event.dart';
import 'package:firfir_tera/bloc/login/login_state.dart';
import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: Login1(),
      ),
    );
  }
}

class Login1 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: BlocProvider(
            lazy: false,
            create: (context) => LoginBloc(
              authRepo: context.read<AuthRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BrandPromo(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Text("Login to your Account",
                        style: GoogleFonts.firaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        )),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _loginForm(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have Account? '),
                        GestureDetector(
                          onTap: () {
                            context.goNamed("/register_1");
                          },
                          child: const MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.orange,
                                ),
                              )),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context1) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          } else if (formStatus is SubmissionSuccess) {
            _showSnackBar(context, 'Success');
            debugPrint('Context: $context1');
            context.goNamed("/home");
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _usernameField(),
                const SizedBox(
                  height: 20,
                ),
                _passwordField(),
                const SizedBox(
                  height: 30,
                ),
                _loginButton(),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'email',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20)))),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginUsernameChanged(username: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
          ),
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? true) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: const Text('Login'),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
