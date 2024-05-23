import 'package:equatable/equatable.dart';
import 'package:firfir_tera/presentation/screens/profile.dart';

class User extends Equatable {
  final Register1 register1;
  final Register2 register2;
  final ProfileImage profileImage;
  const User(
      {required this.register1,
      required this.register2,
      required this.profileImage});

  factory User.empty() {
    return User(
      register1: Register1.empty(),
      register2: Register2.empty(),
      profileImage: ProfileImage.empty(),
    );
  }

  User copyWith({
    Register1? register1,
    Register2? register2,
    ProfileImage? profileImage,
  }) {
    return User(
      register1: register1 ?? this.register1,
      register2: register2 ?? this.register2,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [register1, register2, profileImage];
}

class Register1 extends Equatable {
  const Register1({
    required this.email,
    required this.password,
    required this.accountType,
  });

  final String email;
  final String password;
  final UserType accountType;

  factory Register1.empty() {
    return const Register1(
      email: '',
      password: '',
      accountType: UserType.normal,
    );
  }

  Register1 copyWith({
    String? email,
    String? password,
    UserType? accountType,
  }) {
    return Register1(
      email: email ?? this.email,
      password: password ?? this.password,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  List<Object?> get props => [email, password, accountType];
}

class Register2 extends Equatable {
  const Register2({
    required this.firstName,
    required this.lastName,
    required this.bio,
  });

  final String firstName;
  final String lastName;
  final String bio;

  factory Register2.empty() {
    return const Register2(
      firstName: '',
      lastName: '',
      bio: '',
    );
  }

  Register2 copyWith({
    String? firstName,
    String? lastName,
    String? bio,
  }) {
    return Register2(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, bio];
}

class ProfileImage extends Equatable {
  const ProfileImage({
    required this.imageName,
    required this.imageData,
  });

  final String imageName;
  final String imageData;

  ProfileImage.empty()
      : imageName = '',
        imageData = '';

  ProfileImage copyWith({
    String? imageName,
    String? imageData,
  }) {
    return ProfileImage(
      imageName: imageName ?? this.imageName,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  List<Object?> get props => [imageName, imageData];
}

enum UserType {
  normal,
  cook,
}
