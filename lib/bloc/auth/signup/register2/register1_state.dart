import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';

class Register1State {
  final String email;
  bool get isValidemail => email.length > 3;

  final String password;
  bool get isValidPassword => password.length > 6;
  final String accountType;
  bool get isValidAccountType => accountType.length > 3;

  final FormSubmissionStatus formStatus;

  Register1State({
    this.email = '',
    this.password = '',
    this.accountType = '',
    this.formStatus = const InitialFormStatus(),
  });

  Register1State copyWith({
    String? email,
    String? password,
    String? accountType,
    FormSubmissionStatus? formStatus,
  }) {
    return Register1State(
      email: email ?? this.email,
      password: password ?? this.password,
      accountType: accountType ?? this.accountType,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
