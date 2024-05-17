import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';

class Register3State {
  final String imageData;
  final String imageName;
  final FormSubmissionStatus formStatus;
  final bool isImagePosted;

  Register3State(
      {this.imageData = '',
      this.imageName = '',
      this.formStatus = const InitialFormStatus(),
      this.isImagePosted = false});

  Register3State copyWith({
    String? imageData,
    String? imageName,
    FormSubmissionStatus? formStatus,
  }) {
    return Register3State(
      imageData: imageData ?? this.imageData,
      imageName: imageName ?? this.imageName,
      formStatus: formStatus ?? this.formStatus,
      isImagePosted: imageName != null && imageName.isNotEmpty,
    );
  }
}

class Register3Initial extends Register3State {}

class Register3ImageUploaded extends Register3State {}
