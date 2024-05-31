import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/authRepository.dart';
import 'package:firfir_tera/application/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/application/bloc/auth/auth_even.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/application/bloc/login/login_bloc.dart';
import 'package:firfir_tera/application/bloc/login/login_event.dart';
import 'package:firfir_tera/application/bloc/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthRepository, AuthBloc])
import 'mocks/login_bloc_test.mocks.dart';

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;
    late MockAuthRepository mockAuthRepository;
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockAuthBloc = MockAuthBloc();
      loginBloc =
          LoginBloc(authRepo: mockAuthRepository, authBloc: mockAuthBloc);
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is LoginState()', () {
      expect(loginBloc.state, const LoginState());
    });

    blocTest<LoginBloc, LoginState>(
      'emits LoginState(username: "test") when LoginUsernameChanged is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginUsernameChanged(username: 'test')),
      expect: () =>
          [const LoginState(username: 'test', formStatus: InitialFormStatus())],
    );

    blocTest<LoginBloc, LoginState>(
      'emits LoginState(password: "password") when LoginPasswordChanged is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginPasswordChanged(password: 'password')),
      expect: () => [
        const LoginState(password: 'password', formStatus: InitialFormStatus())
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState(formStatus: FormSubmitting()), LoginState(formStatus: SubmissionSuccess())] when LoginSubmitted is added and login is successful',
      build: () {
        when(mockAuthRepository.login(any, any))
            .thenAnswer((_) async => 'token');
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted()),
      expect: () => [
        LoginState(formStatus: FormSubmitting()),
        LoginState(formStatus: SubmissionSuccess()),
      ],
      verify: (_) {
        verify(mockAuthBloc.add(const LoggedIn('token'))).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginState(formStatus: FormSubmitting()), LoginState(formStatus: SubmissionFailed(Exception))] when LoginSubmitted is added and login fails',
      build: () {
        when(mockAuthRepository.login(any, any))
            .thenThrow(Exception('Failed to login'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted()),
      expect: () => [
        LoginState(formStatus: FormSubmitting()),
        LoginState(formStatus: SubmissionFailed(Exception('Failed to login'))),
      ],
    );
  });
}
