import 'package:firfir_tera/presentation/pages/home/bloc/home_event.dart';
import 'package:firfir_tera/presentation/pages/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventIndexSelected>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
