import 'package:firfir_tera/bloc/auth/authRepository.dart';
import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:firfir_tera/bloc/auth/login/login_event.dart';
import 'package:firfir_tera/bloc/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<LoginUsernameChanged>((event, emit) {
      emit(state.copyWith(
          username: event.username, formStatus: const InitialFormStatus()));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password, formStatus: const InitialFormStatus()));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.login(state.username, state.password);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    });
  }
}
