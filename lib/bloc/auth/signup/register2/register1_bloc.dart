import 'package:firfir_tera/bloc/auth/form_submistion_status.dart';
import 'package:firfir_tera/bloc/auth/model/user.dart';
import 'package:firfir_tera/bloc/auth/signup/register1/register1_event.dart';
import 'package:firfir_tera/bloc/auth/signup/register1/register1_state.dart';
import 'package:firfir_tera/bloc/auth/userRepositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register1Bloc extends Bloc<Register1Event,Register1State> {
  final UserRepository userRepo;
  

  Register1Bloc({required this.userRepo}) : super(Register1State());

  @override
  Stream<Register1State> mapEventToState(Register1Event event) async* {
    // email updated
    if (event is RegisterEmailChanged) {
      
      yield state.copyWith(email: event.email);

      // password updated
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(password: event.password);

      // accountType updated
    } else if (event is RegisterAccountTypeChanged) {
      yield state.copyWith(accountType: event.accountType);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await userRepo.updateRegister1(email: state.email, password: state.password, accountType: state.accountType as UserType) ;
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
      }
    }

  }
}
