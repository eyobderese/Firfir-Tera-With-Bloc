import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:firfir_tera/bloc/signup/register3/register3_bloc.dart';
import 'package:firfir_tera/bloc/signup/register3/register3_event.dart';
import 'package:firfir_tera/bloc/signup/register3/register3_state.dart';
import 'package:firfir_tera/Repository/userRepositery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'dart:convert';

class Register_3 extends StatelessWidget {
  const Register_3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => Register3Bloc(
        userRepo: context.read<UserRepository>(),
      ),
      child: const _Register_3(),
    );
  }
}

class _Register_3 extends StatefulWidget {
  const _Register_3({super.key});

  @override
  State<_Register_3> createState() => _Register_3State();
}

class _Register_3State extends State<_Register_3> {
  Future<void> _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      final base64Image = base64Encode(bytes);
      final imageName = pickedImage.path.split('/').last;
      context
          .read<Register3Bloc>()
          .add(UploadImageEvent(base64Image, imageName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<Register3Bloc, Register3State>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, 'Success');
          context.goNamed("/home");
        }
      },
      child: Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.goNamed("/register_2");
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
                      "Upload Your Photo Profile",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    Text(
                      "The Photo Will be Displayed in Your Account Profile",
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
                GestureDetector(
                  onTap: () => _getImage(context),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: 200,
                      height: 200,
                      // padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: BlocBuilder<Register3Bloc, Register3State>(
                        builder: (context, state) {
                          if (state.isImagePosted) {
                            return Image.memory(
                              base64Decode(state.imageData),
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "Upload",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<Register3Bloc>()
                            .add(Registration3SubmittedEvent());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        minimumSize:
                            MaterialStateProperty.all(const Size(130, 60)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Finish",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}


// use