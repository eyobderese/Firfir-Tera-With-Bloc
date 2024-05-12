// creating navigation bloc with dynamic state
import 'package:firfir_tera/bloc/navigation/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc(this.navigatorKey) : super(null);

  @override
  Stream<dynamic> mapEventToState(NavigationEvent event) async* {
    if (event is NavigateTo) {
      navigatorKey.currentState?.pushNamed(event.routeName);
    }
  }
}
