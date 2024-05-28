import 'package:firfir_tera/bloc/admin/admin_bloc.dart';
import 'package:firfir_tera/bloc/admin/admin_state.dart';
import 'package:firfir_tera/bloc/admin/userDto.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/services/User.dart';
import 'package:firfir_tera/presentation/screens/user_detail_for_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPanel extends StatelessWidget {
  final List<UserDto> users = [
    UserDto(
      id: "1",
      firstName: "Naol",
      lastName: "Daba",
      email: "afaklsdj@gmail.com",
      role: "normal",
    ),
    UserDto(
        id: "2",
        firstName: "Eyob",
        lastName: "Derese",
        email: "afaklsdj@gmail.com",
        role: "cook"),
    UserDto(
        id: "3",
        firstName: "Anatoli",
        lastName: "Derese",
        email: "afaklsdj@gmail.com",
        role: "cook"),
    UserDto(
        id: "4",
        firstName: "Aregawi",
        lastName: "Fikre",
        email: "afaklsdj@gmail.com",
        role: "normal"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        centerTitle: true,
      ),
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AdminLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AdminLoaded) {
              return _buildAdminPanel(state.users.length, state.users);
            } else if (state is AdminError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Add new Admin"),
            ),
          );
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.person_add),
      ),
    );
  }

  Column _buildAdminPanel(int state, List<UserDto> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetails(
                          user: users[
                              index]), //TODO: change userDto from name only to firstName and LastName
                    ),
                  );
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        users[index].firstName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        users[index].email,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("User ${users[index].firstName} banned"),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
