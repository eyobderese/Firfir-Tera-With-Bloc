import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:firfir_tera/bloc/auth/model/user.dart';
import 'package:firfir_tera/bloc/auth/signup/register1/register1_event.dart';
import 'package:firfir_tera/bloc/auth/signup/register1/register1_state.dart';
import 'package:firfir_tera/bloc/auth/userRepositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register1Bloc extends Bloc<Register1Event, Register1State> {
  final UserRepository userRepo;

  Register1Bloc({required this.userRepo}) : super(Register1State()) {
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(
          email: event.email, formStatus: const InitialFormStatus()));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password, formStatus: const InitialFormStatus()));
    });

    on<RegisterAccountTypeChanged>((event, emit) {
      emit(state.copyWith(
          accountType: event.accountType,
          formStatus: const InitialFormStatus()));
    });

    on<Registration1Submitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await userRepo.updateRegister1(
          email: state.email,
          password: state.password,
          accountType: state.accountType,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    });
  }
}
