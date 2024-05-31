import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/Domain/Entities/user.dart';

class Register1State {
  final String email;
  bool get isValidemail => email.length > 3;

  final String password;
  bool get isValidPassword => password.length > 6;
  final UserType accountType;

  final FormSubmissionStatus formStatus;

  Register1State({
    this.email = '',
    this.password = '',
    this.accountType = UserType.normal,
    this.formStatus = const InitialFormStatus(),
  });

  Register1State copyWith({
    String? email,
    String? password,
    UserType? accountType,
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
