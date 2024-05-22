import 'package:firfir_tera/Repository/profileRrepository.dart';
import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:firfir_tera/bloc/edit_profile/edite_profile_event.dart';
import 'package:firfir_tera/bloc/edit_profile/edite_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ImagePicker _picker = ImagePicker();
  final ProfileRepository profileRepository;

  EditProfileBloc({required this.profileRepository})
      : super(EditProfileState()) {
    on<NameUpdated>((event, emit) {
      emit(state.copyWith(
          name: event.name, formStatus: const InitialFormStatus()));
    });

    on<EmailUpdated>((event, emit) {
      emit(state.copyWith(
          email: event.email, formStatus: const InitialFormStatus()));
    });

    on<BioUpdated>((event, emit) {
      emit(state.copyWith(
          bio: event.bio, formStatus: const InitialFormStatus()));
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

      try {
        if (state.name != null && state.email != null && state.bio != null) {
          await profileRepository.updateProfile(
            name: state.name!,
            email: state.email!,
            bio: state.bio!,
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
