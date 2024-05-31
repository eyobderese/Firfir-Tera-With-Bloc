import 'package:equatable/equatable.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';

class Register2State extends Equatable {
  final String firstName;
  bool get isValidfirstName => firstName.length > 3;

  final String lastName;
  bool get isValidlastName => lastName.length > 3;
  final String bio;
  bool get isValiddBio => lastName.length > 3;

  final FormSubmissionStatus formStatus;

  Register2State({
    this.firstName = '',
    this.lastName = '',
    this.bio = '',
    this.formStatus = const InitialFormStatus(),
  });

  Register2State copyWith({
    String? firstName,
    String? lastName,
    String? bio,
    FormSubmissionStatus? formStatus,
  }) {
    return Register2State(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, bio, formStatus];
}
