// creating Loging event
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
  final String accountType;

  RegisterAccountTypeChanged({required this.accountType});
}

class LoginSubmitted extends Register1Event {}
