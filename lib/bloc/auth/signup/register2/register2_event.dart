// creating Loging event

abstract class Register2Event {}

class RegisterFirstNameChanged extends Register2Event {
  final String firstName;
  RegisterFirstNameChanged({required this.firstName});
}

class RegisterLastNameChanged extends Register2Event {
  final String lastName;

  RegisterLastNameChanged({required this.lastName});
}

class RegisterBioChanged extends Register2Event {
  final String bio;

  RegisterBioChanged({required this.bio});
}

class Registration2Submitted extends Register2Event {}
