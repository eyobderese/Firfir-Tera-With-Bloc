// auth_state.dart
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String token = "";
  final String userId = "";
  final String role = "";

  const AuthState();

  @override
  List<Object> get props => [token, userId, role];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final String userId;
  final String role;

  const AuthAuthenticated(this.token, this.userId, this.role);

  @override
  List<Object> get props => [token, userId, role];
}

class AuthUnauthenticated extends AuthState {}
