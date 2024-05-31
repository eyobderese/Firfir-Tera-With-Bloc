import 'package:firfir_tera/Domain/Repository%20Interface/profileRrepository.dart';
import 'package:firfir_tera/application/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/application/bloc/auth/auth_even.dart';
import 'package:firfir_tera/Domain/Entities/profile.dart';
import 'package:firfir_tera/infrastructure/services/authService.dart';
import 'package:firfir_tera/presentation/pages/profile/screen/edit_profile.dart';
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
      image: 'http://10.0.2.2:3000/uploads/placeholder-person.png');

  String _role = "";

  void fetchProfile() async {
    try {
      final profile = await ProfileRepository().getProfile();
      final role = await AuthService().getRole();

      setState(() {
        _profile = profile;
        _role = role!;
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
      key: const Key('profile_page'),
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
              const SizedBox(height: 10),
              Text(
                '$_role',
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                  if (result == true) {
                    fetchProfile();
                    setState(() {});
                  }
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
                key: const Key('logout_button'),
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
