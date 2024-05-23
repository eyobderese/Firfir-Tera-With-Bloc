import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:firfir_tera/bloc/signup/register2/register2_bloc.dart';
import 'package:firfir_tera/bloc/signup/register2/register2_state.dart';
import 'package:firfir_tera/bloc/signup/register2/register2_event.dart';
import 'package:firfir_tera/Repository/userRepositery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Register_2 extends StatelessWidget {
  Register_2({super.key});

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.goNamed("/register_1");
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 40,
                        ),
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Fill in Your Bio to get Started",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      Text(
                        "The data will be displayed in your account profile ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BlocProvider(
                      create: (context) => Register2Bloc(
                        userRepo: context.read<UserRepository>(),
                      ),
                      child: _register2Form(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _register2Form() {
    return BlocListener<Register2Bloc, Register2State>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, 'Success');
          context.goNamed("/register_3");
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
            _firstNameField(),
            const SizedBox(
              height: 5,
            ),
            _lastNameField(),
            const SizedBox(
              height: 20,
            ),
            _bioField(),
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

  Widget _firstNameField() {
    return BlocBuilder<Register2Bloc, Register2State>(
        builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
          ),
        ),
        onChanged: (value) => context
            .read<Register2Bloc>()
            .add(RegisterFirstNameChanged(firstName: value)),
      );
    });
  }

  Widget _lastNameField() {
    return BlocBuilder<Register2Bloc, Register2State>(
        builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
          ),
        ),
        onChanged: (value) => context
            .read<Register2Bloc>()
            .add(RegisterLastNameChanged(lastName: value)),
      );
    });
  }

  Widget _bioField() {
    return BlocBuilder<Register2Bloc, Register2State>(
        builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.chat),
          labelText: "Bio",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
          ),
        ),
        onChanged: (value) =>
            context.read<Register2Bloc>().add(RegisterBioChanged(bio: value)),
      );
    });
  }

  Widget _registerButton() {
    return BlocBuilder<Register2Bloc, Register2State>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? true) {
                  context.read<Register2Bloc>().add(Registration2Submitted());
                }
              },
              child: const Text('Next'),
            );
    });
  }
}
