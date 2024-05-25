import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileState {
  final String? firstName;
  bool get isValidfirstName => firstName!.length > 3;
  final String? lastName;
  bool get isValidlastName => lastName!.length > 3;
  final String? email;
  bool get isValidEmail => email!.length > 3;
  final XFile? imageData;
  final FormSubmissionStatus formStatus;

  EditProfileState({
    this.firstName,
    this.lastName,
    this.email,
    this.imageData,
    this.formStatus = const InitialFormStatus(),
  });

  EditProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    XFile? imageData,
    FormSubmissionStatus? formStatus,
  }) {
    return EditProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageData: imageData ?? this.imageData,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
