class HomeState {
  final int selectedIndex;

  HomeState(this.selectedIndex);

  HomeState copyWith({int? selectedIndex}) {
    return HomeState(selectedIndex ?? this.selectedIndex);
  }
}

class HomeInitial extends HomeState {
  HomeInitial() : super(0);
}
