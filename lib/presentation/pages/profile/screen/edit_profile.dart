import 'dart:io';
import 'package:firfir_tera/Domain/Repository%20Interface/profileRrepository.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/application/bloc/edit_profile/edite_profile_bloc.dart';
import 'package:firfir_tera/presentation/pages/profile/bloc/edite_profile_event.dart';
import 'package:firfir_tera/presentation/pages/profile/bloc/edite_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: const Text("Edit Profile"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (context) => EditProfileBloc(
            profileRepository: context.read<ProfileRepository>(),
          ),
          child: _EdditProfileForm(context),
        ),
      ),
    );
  }

  Widget _EdditProfileForm(BuildContext context1) {
    return BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          final formStatus = state.formStatus;

          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          } else if (formStatus is SubmissionSuccess) {
            _showSnackBar(context, 'Success');
            debugPrint('Context: $context1');
            Navigator.pop(context, true);
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _profileImageField(),
                const SizedBox(height: 10),
                const Text("Edit Profile Picture"),
                const SizedBox(height: 30),
                _firstNameField(),
                const SizedBox(height: 20),
                _lastNameField(),
                const SizedBox(height: 20.0),
                _EmailField(),
                const SizedBox(height: 20.0),
                _SaveButton(),
              ],
            ),
          ),
        ));
  }

  Widget _profileImageField() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context, builder: (builder) => bottomSheet(context));
          },
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orange,
            child: state.imageData != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(state.imageData!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
          ),
        ),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _firstNameField() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: 'First Name',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20)))),
        validator: (value) =>
            state.isValidfirstName ? null : 'Name is too short',
        onChanged: (value) => context.read<EditProfileBloc>().add(
              FirstNameUpdated(value),
            ),
      );
    });
  }

  Widget _lastNameField() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: 'last Name',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20)))),
        validator: (value) =>
            state.isValidlastName ? null : 'Name is too short',
        onChanged: (value) => context.read<EditProfileBloc>().add(
              LastNameUpdated(value),
            ),
      );
    });
  }

  Widget _EmailField() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'Email',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20)))),
        validator: (value) => state.isValidEmail ? null : 'Email is too short',
        onChanged: (value) => context.read<EditProfileBloc>().add(
              EmailUpdated(value),
            ),
      );
    });
  }

  Widget _SaveButton() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () async {
                context.read<EditProfileBloc>().add(ProfileSubmitted());
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  minimumSize: MaterialStateProperty.all(const Size(90, 40)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)))),
              child: const Text(
                'Save Changes',
              ),
            );
    });
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
                      .read<EditProfileBloc>()
                      .add(ImageUpdated(ImageSource.camera));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  context
                      .read<EditProfileBloc>()
                      .add(ImageUpdated(ImageSource.gallery));
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
