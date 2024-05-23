import 'package:firfir_tera/Repository/authRepository.dart';
import 'package:firfir_tera/bloc/form_submistion_status.dart';
import 'package:firfir_tera/bloc/signup/register3/register3_event.dart';
import 'package:firfir_tera/bloc/signup/register3/register3_state.dart';
import 'package:firfir_tera/Repository/userRepositery.dart';
import 'package:firfir_tera/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register3Bloc extends Bloc<Register3Event, Register3State> {
  final UserRepository userRepo;
  final AuthRepository authRepo;

  Register3Bloc({required this.userRepo, required this.authRepo})
      : super(Register3Initial()) {
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

        final String firstName = userRepo.getUser().register2.firstName;
        final String lastName = userRepo.getUser().register2.lastName;
        final String email = userRepo.getUser().register1.email;
        final String password = userRepo.getUser().register1.password;
        final String role =
            userRepo.getUser().register1.accountType == UserType.normal
                ? 'normal'
                : 'cook';
        final String bio = userRepo.getUser().register2.bio;

        await authRepo.signup(firstName, lastName, email, password, role, bio);

        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    });
  }
}
