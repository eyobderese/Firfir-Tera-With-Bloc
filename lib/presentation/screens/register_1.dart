import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:firfir_tera/model/user.dart';
import 'package:firfir_tera/bloc/signup/register1/register1_bloc.dart';
import 'package:firfir_tera/bloc/signup/register1/register1_state.dart';
import 'package:firfir_tera/bloc/signup/register1/register1_event.dart';
import 'package:firfir_tera/Repository/userRepositery.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Register_1 extends StatelessWidget {
  Register_1({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/log_reg_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: BlocProvider(
              lazy: false,
              create: (context) =>
                  Register1Bloc(userRepo: context.read<UserRepository>()),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BrandPromo(color: Colors.white),
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Sign Up for free",
                      style: GoogleFonts.firaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _register1Form(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  context.goNamed("/login");
                                },
                                child: const Text('Login',
                                    style: TextStyle(color: Colors.orange)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _register1Form() {
    return BlocListener<Register1Bloc, Register1State>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, 'Success');
          context.goNamed("/register_2");
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            _emailField(),
            const SizedBox(
              height: 5,
            ),
            _passwordField(),
            const SizedBox(
              height: 10,
            ),
            _userTypeField(),
            const SizedBox(
              height: 50,
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _emailField() {
    return BlocBuilder<Register1Bloc, Register1State>(
        builder: (context, state) {
      return TextFormField(
        validator: (value) => state.isValidemail ? null : 'invalid email',
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: "email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
          ),
        ),
        onChanged: (value) => context
            .read<Register1Bloc>()
            .add(RegisterEmailChanged(email: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<Register1Bloc, Register1State>(
        builder: (context, state) {
      return TextFormField(
        obscureText: true,
        validator: (value) =>
            state.isValidPassword ? null : 'password is too short',
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
          ),
        ),
        onChanged: (value) => context
            .read<Register1Bloc>()
            .add(RegisterPasswordChanged(password: value)),
      );
    });
  }

  Widget _userTypeField() {
    return BlocBuilder<Register1Bloc, Register1State>(
        builder: (context, state) {
      return DropdownButtonFormField<UserType>(
        value: state.accountType,
        onChanged: (value) => context
            .read<Register1Bloc>()
            .add(RegisterAccountTypeChanged(accountType: value)),
        items: UserType.values.map((UserType type) {
          return DropdownMenuItem<UserType>(
            value: type,
            child: Text(
              type == UserType.customer ? 'I am a Customer' : 'I am a Cook',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: "User Type",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
          ),
        ),
      );
    });
  }

  Widget _registerButton() {
    return BlocBuilder<Register1Bloc, Register1State>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? true) {
                  context.read<Register1Bloc>().add(Registration1Submitted());
                }
              },
              child: const Text('Next'),
            );
    });
  }
}
