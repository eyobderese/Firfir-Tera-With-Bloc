import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:firfir_tera/bloc/auth/signup/register3/register3_event.dart';
import 'package:firfir_tera/bloc/auth/signup/register3/register3_state.dart';
import 'package:firfir_tera/bloc/auth/userRepositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register3Bloc extends Bloc<Register3Event, Register3State> {
  final UserRepository userRepo;

  Register3Bloc({required this.userRepo}) : super(Register3Initial()) {
    on<UploadImageEvent>((event, emit) {
      emit(state.copyWith(
          imageData: event.imageData,
          imageName: event.imageName,
          formStatus: const InitialFormStatus()));
    });

    on<Registration3SubmittedEvent>((event, emit) async {
      emit(state.copyWith(
          imageName: state.imageName, formStatus: FormSubmitting()));

      try {
        await userRepo.updateProfileImage(
          imageData: state.imageData,
          imageName: state.imageName,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    });
  }
}
