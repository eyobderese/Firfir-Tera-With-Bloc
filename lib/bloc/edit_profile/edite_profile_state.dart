import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileState {
  final String? name;
  bool get isValidName => name!.length > 3;
  final String? email;
  bool get isValidEmail => email!.length > 3;
  final String? bio;
  bool get isValidBio => bio!.length > 3;
  final XFile? imageData;
  final FormSubmissionStatus formStatus;

  EditProfileState({
    this.name,
    this.email,
    this.bio,
    this.imageData,
    this.formStatus = const InitialFormStatus(),
  });

  EditProfileState copyWith({
    String? name,
    String? email,
    String? bio,
    XFile? imageData,
    FormSubmissionStatus? formStatus,
  }) {
    return EditProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      imageData: imageData ?? this.imageData,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
