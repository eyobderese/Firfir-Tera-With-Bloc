// login_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/application/bloc/auth/auth_bloc.dart';
import 'package:firfir_tera/application/bloc/auth/auth_even.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/application/bloc/login/login_bloc.dart';
import 'package:firfir_tera/application/bloc/login/login_event.dart';
import 'package:firfir_tera/application/bloc/login/login_state.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/authRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/login_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, AuthBloc])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockAuthBloc mockAuthBloc;
  late LoginBloc loginBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAuthBloc = MockAuthBloc();
    loginBloc = LoginBloc(authRepo: mockAuthRepository, authBloc: mockAuthBloc);
  });

  group('LoginBloc', () {
    test('Initial state should be LoginState', () {
      expect(
          loginBloc.state,
          LoginState(
              username: '', password: '', formStatus: InitialFormStatus()));
    });

    blocTest<LoginBloc, LoginState>(
      'UsernameChanged event should update username in state',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginUsernameChanged(username: 'testuser')),
      expect: () => [
        LoginState(
            username: 'testuser', password: '', formStatus: InitialFormStatus())
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'PasswordChanged event should update password in state',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginPasswordChanged(password: 'password')),
      expect: () => [
        LoginState(
            username: '', password: 'password', formStatus: InitialFormStatus())
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'LoginSubmitted event should emit [FormSubmitting, SubmissionSuccess] '
      'when login is successful',
      build: () {
        when(mockAuthRepository.login('testuser', 'password'))
            .thenAnswer((_) async => 'token');
        when(mockAuthRepository.getUserId()).thenAnswer((_) async => 'userId');
        when(mockAuthRepository.getRole()).thenAnswer((_) async => 'role');
        return loginBloc;
      },
      act: (bloc) async {
        bloc.add(LoginUsernameChanged(username: 'testuser'));
        bloc.add(LoginPasswordChanged(password: 'password'));
        bloc.add(LoginSubmitted());
      },
      expect: () => [
        LoginState(
            username: 'testuser',
            password: '',
            formStatus: InitialFormStatus()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: InitialFormStatus()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: FormSubmitting()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: SubmissionSuccess())
      ],
      verify: (_) {
        verify(mockAuthRepository.login('testuser', 'password')).called(1);
        verify(mockAuthBloc.add(LoggedIn('token', 'userId', 'role'))).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'LoginSubmitted event should emit [FormSubmitting, SubmissionFailed] '
      'when login fails',
      build: () {
        when(mockAuthRepository.login('testuser', 'password'))
            .thenThrow(Exception('Failed to login'));
        return loginBloc;
      },
      act: (bloc) async {
        bloc.add(LoginUsernameChanged(username: 'testuser'));
        bloc.add(LoginPasswordChanged(password: 'password'));
        bloc.add(LoginSubmitted());
      },
      expect: () => [
        LoginState(
            username: 'testuser',
            password: '',
            formStatus: InitialFormStatus()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: InitialFormStatus()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: FormSubmitting()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: SubmissionFailed(Exception('Failed to login')))
      ],
      verify: (_) {
        verify(mockAuthRepository.login('testuser', 'password')).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'LoginSubmitted event should emit [FormSubmitting, SubmissionFailed] '
      'when an exception occurs',
      build: () {
        when(mockAuthRepository.login('testuser', 'password'))
            .thenThrow(Exception('Login error'));
        return loginBloc;
      },
      act: (bloc) async {
        bloc.add(LoginUsernameChanged(username: 'testuser'));
        bloc.add(LoginPasswordChanged(password: 'password'));
        bloc.add(LoginSubmitted());
      },
      expect: () => [
        LoginState(
            username: 'testuser',
            password: '',
            formStatus: InitialFormStatus()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: InitialFormStatus()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: FormSubmitting()),
        LoginState(
            username: 'testuser',
            password: 'password',
            formStatus: SubmissionFailed(Exception('Login error')))
      ],
      verify: (_) {
        verify(mockAuthRepository.login('testuser', 'password')).called(1);
      },
    );
  });
}
