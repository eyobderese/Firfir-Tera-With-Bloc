// creating Loging event

import 'package:firfir_tera/Domain/Entities/user.dart';

abstract class Register1Event {}

class RegisterEmailChanged extends Register1Event {
  final String email;
  RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends Register1Event {
  final String password;

  RegisterPasswordChanged({required this.password});
}

class RegisterAccountTypeChanged extends Register1Event {
  final UserType? accountType;

  RegisterAccountTypeChanged({this.accountType});
}

class Registration1Submitted extends Register1Event {}
