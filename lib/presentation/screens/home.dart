import 'package:firfir_tera/bloc/Home/home_bloc.dart';
import 'package:firfir_tera/bloc/Home/home_event.dart';
import 'package:firfir_tera/bloc/Home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/screens/discover.dart';
import 'package:firfir_tera/presentation/screens/profile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  static const List<Widget> _pages = <Widget>[
    Discover(),
    CreateRecipe(),
    Profile(),
  ];

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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded),
                label: 'Add Recipe',
              ),
              BottomNavigationBarItem(
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
