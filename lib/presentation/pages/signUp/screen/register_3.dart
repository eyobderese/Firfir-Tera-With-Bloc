import 'dart:io';

import 'package:firfir_tera/Domain/Repository%20Interface/authRepository.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/application/bloc/signup/register3/register3_bloc.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register3_event.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register3_state.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class Register_3 extends StatelessWidget {
  const Register_3({super.key});

  @override
  Widget build(BuildContext context) {
    return _Register_3();
  }
}

class _Register_3 extends StatefulWidget {
  const _Register_3({super.key});

  @override
  State<_Register_3> createState() => _Register_3State();
}

class _Register_3State extends State<_Register_3> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<Register3Bloc, Register3State>(
      key: Key('register_3_page'),
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (state.formStatus is NoImageSelected) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No image selected. Please select an image'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, 'You are Registerd Successfully');

          Future.delayed(Duration(seconds: 1));
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
                      key: Key('register3_back_button'),
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
                  key: const Key('register3_image_button'),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => bottomSheet(context),
                  ),
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
                          if (state.image != null) {
                            return Image.file(
                              File(state.image!.path),
                              fit: BoxFit.cover,
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "Select Image",
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
                      key: Key('register3_finish_button'),
                      onPressed: () {
                        if (context.read<Register3Bloc>().state.image == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    'No image selected. Please select an image'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          context
                              .read<Register3Bloc>()
                              .add(Registration3SubmittedEvent());
                        }
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

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Choose Image', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  context
                      .read<Register3Bloc>()
                      .add(const UploadImageEvent(ImageSource.camera));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  context
                      .read<Register3Bloc>()
                      .add(const UploadImageEvent(ImageSource.gallery));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
