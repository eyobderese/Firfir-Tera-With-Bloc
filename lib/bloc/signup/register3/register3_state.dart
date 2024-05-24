import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:image_picker/image_picker.dart';

class Register3State {
  final XFile? image;
  final FormSubmissionStatus formStatus;
  final bool isImagePosted;

  Register3State(
      {this.image,
      this.formStatus = const InitialFormStatus(),
      this.isImagePosted = false});

  Register3State copyWith({
    FormSubmissionStatus? formStatus,
    XFile? image,
  }) {
    return Register3State(
      image: image ?? this.image,
      formStatus: formStatus ?? this.formStatus,
      isImagePosted: image != null,
    );
  }
}

class Register3Initial extends Register3State {}

class Register3ImageUploaded extends Register3State {}
