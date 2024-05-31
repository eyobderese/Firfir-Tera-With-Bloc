import 'package:firfir_tera/Domain/Repository%20Interface/authRepository.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register3_event.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register3_state.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';
import 'package:firfir_tera/Domain/Entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Register3Bloc extends Bloc<Register3Event, Register3State> {
  final UserRepository userRepo;
  final AuthRepository authRepo;
  final _picker = ImagePicker();

  Register3Bloc({required this.userRepo, required this.authRepo})
      : super(Register3Initial()) {
    on<UploadImageEvent>((event, emit) async {
      final pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(
            state.copyWith(image: pickedFile, formStatus: InitialFormStatus()));
      } else {
        emit(state.copyWith(formStatus: const NoImageSelected()));
      }
      print(pickedFile?.path);
    });

    on<Registration3SubmittedEvent>((event, emit) async {
      emit(state.copyWith(image: state.image, formStatus: FormSubmitting()));

      try {
        await userRepo.updateProfileImage(
          image: state.image!,
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

        final XFile image = userRepo.getUser().profileImage.image;

        await authRepo.signup(
            firstName, lastName, email, password, role, bio, image);

        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        // emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
        if (e is Exception) {
          emit(state.copyWith(formStatus: SubmissionFailed(e)));
        } else if (e is Error) {
          emit(state.copyWith(
              formStatus: SubmissionFailed(Exception(e.toString()))));
        }
      }
    });
  }
}
