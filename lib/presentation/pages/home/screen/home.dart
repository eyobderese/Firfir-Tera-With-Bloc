import 'package:firfir_tera/application/bloc/Home/home_bloc.dart';
import 'package:firfir_tera/presentation/pages/home/bloc/home_event.dart';
import 'package:firfir_tera/presentation/pages/home/bloc/home_state.dart';
import 'package:firfir_tera/presentation/pages/admin/screen/admin.dart';
import 'package:firfir_tera/infrastructure/services/authService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firfir_tera/presentation/pages/recipe/screen/create_recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/pages/dicovery/screen/discover.dart';
import 'package:firfir_tera/presentation/pages/profile/screen/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userRole = "";
  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  Future<String> fetchUserRole() async {
    return (await AuthService().getRole())!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchUserRole(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading spinner while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error message if something went wrong
        } else {
          String userRole = snapshot.data!;
          return BlocProvider(
            create: (context) => HomeBloc(),
            child: _Home(
              role: userRole,
            ),
          );
        }
      },
    );
  }
}

class _Home extends StatelessWidget {
  final String role;
  const _Home({Key? key, this.role = ""}) : super(key: key);
  static final List<Widget> _cooksPages = <Widget>[
    Discover(),
    const CreateRecipe(),
    const Profile(),
  ];
  static final List<Widget> _adminPages = <Widget>[
    Discover(),
    AdminPanel(),
    const Profile(),
  ];
  static final List<Widget> _nomalPages = <Widget>[
    Discover(),
    const Profile(),
  ];

  List<Widget> get _pages {
    if (role == 'cook') {
      return _cooksPages;
    } else if (role == 'admin') {
      return _adminPages;
    } else {
      return _nomalPages;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<HomeBloc>().add(HomeEventIndexSelected(index));
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Discover',
              ),
              if (role == 'cook')
                const BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_rounded),
                  label: 'Add Recipe',
                ),
              if (role == 'admin')
                const BottomNavigationBarItem(
                  icon: Icon(Icons.admin_panel_settings_rounded),
                  label: 'Admin Panal',
                ),
              const BottomNavigationBarItem(
                key: const Key('profilePageButton'),
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
          ),
        );
      },
    );
  }
}
