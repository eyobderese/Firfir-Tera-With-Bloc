import 'package:firfir_tera/Domain/Repository%20Interface/profileRrepository.dart';
import 'package:firfir_tera/application/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/application/bloc/auth/auth_even.dart';
import 'package:firfir_tera/Domain/Entities/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileModel _profile = ProfileModel(
      firstName: 'Aregawi',
      lastName: 'Fikre',
      email: 'eyobderese123@gmail.com',
      image: 'http://10.0.2.2:3000/uploads/1716673118683.jpg');

  void fetchProfile() async {
    try {
      final profile = await ProfileRepository().getProfile();

      setState(() {
        _profile = profile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(_profile.image),
              ),
              const SizedBox(height: 20),
              Text(
                '${_profile.firstName} ${_profile.lastName}',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '${_profile.email}',
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                key: const Key('editProfileButton'),
                onPressed: () {
                  context.goNamed("/edit_profile");
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    minimumSize: MaterialStateProperty.all(const Size(90, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LoggedOut());
                  context.goNamed("/login");
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(90, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
                child:
                    const Text('Log Out', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
