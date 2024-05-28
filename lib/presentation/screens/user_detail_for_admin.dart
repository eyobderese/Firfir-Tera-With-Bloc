import 'package:firfir_tera/bloc/admin/admin_bloc.dart';
import 'package:firfir_tera/bloc/admin/admin_event.dart';
import 'package:firfir_tera/bloc/admin/admin_state.dart';
import 'package:firfir_tera/bloc/admin/userDto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserDetails extends StatelessWidget {
  final UserDto user;

  UserDetails({required this.user});

  @override
  Widget build(BuildContext context) {
    final bool isNormal = user.role == "normal";
    final adminBloc = BlocProvider.of<AdminBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: BlocListener<AdminBloc, AdminState>(
            listener: (context, state) {
              if (state is AdminError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/userImage.png'),
                  radius: 70.0,
                ),
                SizedBox(height: 20),
                Text(
                  'Name: ${user.firstName} ${user.lastName}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Email: ${user.email}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.read<AdminBloc>().add(
                        isNormal ? PromotUser(user.id) : DemotUser(user.id));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 97, 252, 103),
                    elevation: 5,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    isNormal ? 'Promote User' : 'Demote User',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<AdminBloc>().add(DeleteUser(user.id));
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 99, 89),
                    elevation: 5,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Delete User",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
