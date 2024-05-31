import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register2_event.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register2_state.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register2Bloc extends Bloc<Register2Event, Register2State> {
  final UserRepository userRepo;

  Register2Bloc({required this.userRepo}) : super(Register2State()) {
    on<RegisterFirstNameChanged>((event, emit) {
      emit(state.copyWith(
          firstName: event.firstName, formStatus: const InitialFormStatus()));
    });

    on<RegisterLastNameChanged>((event, emit) {
      emit(state.copyWith(
          lastName: event.lastName, formStatus: const InitialFormStatus()));
    });

    on<RegisterBioChanged>((event, emit) {
      emit(state.copyWith(
          bio: event.bio, formStatus: const InitialFormStatus()));
    });

    on<Registration2Submitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await userRepo.updateRegister2(
          firstName: state.firstName,
          lastName: state.lastName,
          bio: state.bio,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    });
  }
}
