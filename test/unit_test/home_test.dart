import 'package:firfir_tera/application/bloc/Home/home_bloc.dart';
import 'package:firfir_tera/presentation/pages/home/bloc/home_event.dart';
import 'package:firfir_tera/presentation/pages/home/bloc/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = HomeBloc();
    });

    test('home page', () {
      expect(homeBloc.state, isA<HomeInitial>());
      expect(homeBloc.state.selectedIndex, 0);
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState(1)] when HomeEventIndexSelected(1) is added',
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeEventIndexSelected(1)),
      expect: () => [
        isA<HomeState>()
            .having((state) => state.selectedIndex, 'selectedIndex', 1),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState(2)] when HomeEventIndexSelected(2) is added',
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeEventIndexSelected(2)),
      expect: () => [
        isA<HomeState>()
            .having((state) => state.selectedIndex, 'selectedIndex', 2),
      ],
    );
  });
}
