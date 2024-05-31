import 'package:firfir_tera/Domain/Entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  group('User', () {
    final register1 = Register1(
      email: 'test@example.com',
      password: 'password',
      accountType: UserType.normal,
    );
    final register2 = Register2(
      firstName: 'John',
      lastName: 'Doe',
      bio: 'Bio',
    );
    final profileImage = ProfileImage(image: XFile('path/to/image'));

    final user = User(
      register1: register1,
      register2: register2,
      profileImage: profileImage,
    );

    test('copyWith creates correct copy', () {
      final copiedUser = user.copyWith(
        register1: register1.copyWith(email: 'new@example.com'),
        register2: register2.copyWith(firstName: 'Jane'),
        profileImage: ProfileImage(image: XFile('new/path/to/image')),
      );

      expect(copiedUser.register1.email, 'new@example.com');
      expect(copiedUser.register2.firstName, 'Jane');
      expect(copiedUser.profileImage.image.path, 'new/path/to/image');
    });

    test('equality works as expected', () {
      final sameUser = User(
        register1: register1,
        register2: register2,
        profileImage: profileImage,
      );

      expect(user, sameUser);
      expect(user == sameUser, isTrue);

      final differentUser = User.empty();
      expect(user == differentUser, isFalse);
    });
  });

  group('Register1', () {
    final register1 = Register1(
      email: 'test@example.com',
      password: 'password',
      accountType: UserType.normal,
    );

    test('empty factory creates correct instance', () {
      final emptyRegister1 = Register1.empty();
      expect(emptyRegister1.email, '');
      expect(emptyRegister1.password, '');
      expect(emptyRegister1.accountType, UserType.normal);
    });

    test('copyWith creates correct copy', () {
      final copiedRegister1 = register1.copyWith(email: 'new@example.com');
      expect(copiedRegister1.email, 'new@example.com');
      expect(copiedRegister1.password, 'password');
      expect(copiedRegister1.accountType, UserType.normal);
    });

    test('equality works as expected', () {
      final sameRegister1 = Register1(
        email: 'test@example.com',
        password: 'password',
        accountType: UserType.normal,
      );

      expect(register1, sameRegister1);
      expect(register1 == sameRegister1, isTrue);

      final differentRegister1 = Register1.empty();
      expect(register1 == differentRegister1, isFalse);
    });
  });

  group('Register2', () {
    final register2 = Register2(
      firstName: 'John',
      lastName: 'Doe',
      bio: 'Bio',
    );

    test('empty factory creates correct instance', () {
      final emptyRegister2 = Register2.empty();
      expect(emptyRegister2.firstName, '');
      expect(emptyRegister2.lastName, '');
      expect(emptyRegister2.bio, '');
    });

    test('copyWith creates correct copy', () {
      final copiedRegister2 = register2.copyWith(firstName: 'Jane');
      expect(copiedRegister2.firstName, 'Jane');
      expect(copiedRegister2.lastName, 'Doe');
      expect(copiedRegister2.bio, 'Bio');
    });

    test('equality works as expected', () {
      final sameRegister2 = Register2(
        firstName: 'John',
        lastName: 'Doe',
        bio: 'Bio',
      );

      expect(register2, sameRegister2);
      expect(register2 == sameRegister2, isTrue);

      final differentRegister2 = Register2.empty();
      expect(register2 == differentRegister2, isFalse);
    });
  });

  group('ProfileImage', () {
    final profileImage = ProfileImage(image: XFile('path/to/image'));

    test('empty factory creates correct instance', () {
      final emptyProfileImage = ProfileImage.empty();
      expect(emptyProfileImage.image.path, '');
    });

    test('copyWith creates correct copy', () {
      final copiedProfileImage = profileImage.copyWith(imageName: 'newImage');
      expect(copiedProfileImage.image.path, 'path/to/image');
    });

  });
}
