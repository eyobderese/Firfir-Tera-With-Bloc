import 'package:firfir_tera/Repository/profileRrepository.dart';
import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:firfir_tera/bloc/edit_profile/edite_profile_event.dart';
import 'package:firfir_tera/bloc/edit_profile/edite_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ImagePicker _picker = ImagePicker();
  final ProfileRepository profileRepository;

  EditProfileBloc({required this.profileRepository})
      : super(EditProfileState()) {
    on<FirstNameUpdated>((event, emit) {
      emit(state.copyWith(
          firstName: event.firstName, formStatus: const InitialFormStatus()));
    });

    on<EmailUpdated>((event, emit) {
      emit(state.copyWith(
          email: event.email, formStatus: const InitialFormStatus()));
    });

    on<LastNameUpdated>((event, emit) {
      emit(state.copyWith(
          lastName: event.lastName, formStatus: const InitialFormStatus()));
    });

    on<ImageUpdated>((event, emit) async {
      final pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(
          state.copyWith(
              imageData: pickedFile, formStatus: const InitialFormStatus()),
        );
      }
    });

    on<ProfileSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      print(state.imageData!.path);

      try {
        if (state.firstName != null &&
            state.email != null &&
            state.lastName != null) {
          await profileRepository.updateProfile(
            firstName: state.firstName!,
            email: state.email!,
            lastName: state.lastName!,
            imageData: state.imageData,
          );
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } else {
          throw Exception('All fields must be filled');
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    });
  }
}
