import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/application/bloc/formStutes/form_submistion_status.dart';
import 'package:firfir_tera/application/bloc/signup/register1/register1_bloc.dart';
import 'package:firfir_tera/application/bloc/signup/register1/register1_event.dart';
import 'package:firfir_tera/application/bloc/signup/register1/register1_state.dart';
import 'package:firfir_tera/application/bloc/signup/register2/register2_bloc.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register2_event.dart';
import 'package:firfir_tera/presentation/pages/signUp/bloc/register2_state.dart';
import 'package:firfir_tera/Domain/Entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/userRepositery.dart';

@GenerateMocks([UserRepository])
import 'mocks/register_bloc_test.mocks.dart';

void main() {
  group('Register1Bloc', () {
    late Register1Bloc register1Bloc;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      register1Bloc = Register1Bloc(userRepo: mockUserRepository);
    });

    tearDown(() {
      register1Bloc.close();
    });

    test('initial state is Register1State', () {
      expect(register1Bloc.state, Register1State());
    });

    blocTest<Register1Bloc, Register1State>(
      'emits Register1State with email changed event',
      build: () => register1Bloc,
      act: (bloc) => bloc.add(RegisterEmailChanged(email: 'abebe@gmail.com')),
      expect: () => [
        Register1State(
            email: 'abebe@gmail.com', formStatus: const InitialFormStatus())
      ],
    );

    blocTest<Register1Bloc, Register1State>(
      'emits Register1State with password changed event',
      build: () => register1Bloc,
      act: (bloc) =>
          bloc.add(RegisterPasswordChanged(password: 'testPassword')),
      expect: () => [
        Register1State(
            password: 'testPassword', formStatus: const InitialFormStatus())
      ],
    );

    blocTest<Register1Bloc, Register1State>(
      'emits Register1State with account type changed event',
      build: () => register1Bloc,
      act: (bloc) =>
          bloc.add(RegisterAccountTypeChanged(accountType: UserType.cook)),
      expect: () => [
        Register1State(
            accountType: UserType.cook, formStatus: const InitialFormStatus())
      ],
    );

    blocTest<Register1Bloc, Register1State>(
      'emits Register1State with registration submitted event',
      build: () {
        when(mockUserRepository.updateRegister1(
          email: anyNamed('email'),
          password: anyNamed('password'),
          accountType: anyNamed('accountType'),
        )).thenAnswer(
            (_) async => Future.delayed(const Duration(milliseconds: 500)));
        return register1Bloc;
      },
      act: (bloc) async {
        bloc.add(RegisterEmailChanged(email: 'abebe@gmail.com'));
        bloc.add(RegisterPasswordChanged(password: 'testPassword'));
        bloc.add(RegisterAccountTypeChanged(accountType: UserType.normal));
        bloc.add(Registration1Submitted());
        await Future.delayed(const Duration(milliseconds: 600));
      },
      expect: () => [
        Register1State(
            email: 'abebe@gmail.com',
            password: '',
            accountType: UserType.normal,
            formStatus: const InitialFormStatus()),
        Register1State(
            email: 'abebe@gmail.com',
            password: 'testPassword',
            accountType: UserType.normal,
            formStatus: const InitialFormStatus()),
        Register1State(
            email: 'abebe@gmail.com',
            password: 'testPassword',
            accountType: UserType.normal,
            formStatus: FormSubmitting()),
        Register1State(
            email: 'abebe@gmail.com',
            password: 'testPassword',
            accountType: UserType.normal,
            formStatus: SubmissionSuccess())
      ],
    );
  });

  group('Register2Bloc', () {
    late Register2Bloc register2Bloc;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      register2Bloc = Register2Bloc(userRepo: mockUserRepository);
    });

    tearDown(() {
      register2Bloc.close();
    });

    test('initial state is Register2State', () {
      expect(register2Bloc.state, Register2State());
    });

    blocTest<Register2Bloc, Register2State>(
      'emits Register2State with first name changed event',
      build: () => register2Bloc,
      act: (bloc) => bloc.add(RegisterFirstNameChanged(firstName: 'abebe')),
      expect: () => [
        Register2State(
            firstName: 'abebe', formStatus: const InitialFormStatus())
      ],
    );

    blocTest<Register2Bloc, Register2State>(
      'emits Register2State with last name changed event',
      build: () => register2Bloc,
      act: (bloc) => bloc.add(RegisterLastNameChanged(lastName: 'kebede')),
      expect: () => [
        Register2State(
            lastName: 'kebede', formStatus: const InitialFormStatus())
      ],
    );

    blocTest<Register2Bloc, Register2State>(
      'emits Register2State with bio changed event',
      build: () => register2Bloc,
      act: (bloc) =>
          bloc.add(RegisterBioChanged(bio: 'this is a test of a sample bio')),
      expect: () => [
        Register2State(
            bio: 'this is a test of a sample bio',
            formStatus: const InitialFormStatus())
      ],
    );

    blocTest<Register2Bloc, Register2State>(
      'emits Register2State with registration submitted event',
      build: () {
        when(mockUserRepository.updateRegister2(
                firstName: 'abebe',
                lastName: 'kebede',
                bio: 'this is a test of a sample bio'))
            .thenAnswer(
                (_) async => Future.delayed(const Duration(milliseconds: 500)));
        return register2Bloc;
      },
      act: (bloc) async {
        bloc.add(RegisterFirstNameChanged(firstName: 'abebe'));
        bloc.add(RegisterLastNameChanged(lastName: 'kebede'));
        bloc.add(RegisterBioChanged(bio: 'this is a test of a sample bio'));
        bloc.add(Registration2Submitted());
        await Future.delayed(const Duration(milliseconds: 600));
      },
      expect: () => [
        Register2State(
            firstName: 'abebe',
            lastName: '',
            bio: '',
            formStatus: const InitialFormStatus()),
        Register2State(
            firstName: 'abebe',
            lastName: 'kebede',
            bio: '',
            formStatus: const InitialFormStatus()),
        Register2State(
            firstName: 'abebe',
            lastName: 'kebede',
            bio: 'this is a test of a sample bio',
            formStatus: const InitialFormStatus()),
        Register2State(
            firstName: 'abebe',
            lastName: 'kebede',
            bio: 'this is a test of a sample bio',
            formStatus: FormSubmitting()),
        Register2State(
            firstName: 'abebe',
            lastName: 'kebede',
            bio: 'this is a test of a sample bio',
            formStatus: SubmissionSuccess())
      ],
    );
  });
}
