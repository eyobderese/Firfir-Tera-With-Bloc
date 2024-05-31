import 'package:equatable/equatable.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:image_picker/image_picker.dart';

class Register3State extends Equatable {
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

  @override
  List<Object?> get props => [image, formStatus, isImagePosted];
}

class Register3Initial extends Register3State {}

class Register3ImageUploaded extends Register3State {}
