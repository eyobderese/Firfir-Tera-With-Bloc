// creating a navigation event
abstract class NavigationEvent {}

class NavigateTo extends NavigationEvent {
  final String routeName;
  final dynamic arguments;

  NavigateTo(this.routeName, {this.arguments});
}

class NavigateBack extends NavigationEvent {}
