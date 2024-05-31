// auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;
  final String userId;
  final String role;

  const LoggedIn(this.token, this.userId, this.role);

  @override
  List<Object> get props => [token, userId, role];
}

class LoggedOut extends AuthEvent {}
