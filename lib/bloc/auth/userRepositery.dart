import 'model/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return _user ?? User.empty();
  }

  Future<void> updateRegister1({
    required String email,
    required String password,
    required UserType accountType,
  }) async {
    _user ??= User.empty();
    await Future.delayed(const Duration(seconds: 1));
    _user = _user?.copyWith(
      register1: Register1(
        email: email,
        password: password,
        accountType: accountType,
      ),
    );
  }

  Future<void> updateRegister2({
    required String firstName,
    required String lastName,
    required String bio,
  }) async {
    _user ??= User.empty();
    await Future.delayed(const Duration(seconds: 1));
    _user = _user?.copyWith(
      register2: Register2(
        firstName: firstName,
        lastName: lastName,
        bio: bio,
      ),
    );
  }

// it only have imageName and imageData
  Future<void> updateProfileImage({
    required String imageName,
    required String imageData,
  }) async {
    _user ??= User.empty();
    await Future.delayed(const Duration(seconds: 1));
    _user = _user?.copyWith(
      profileImage: ProfileImage(
        imageName: imageName,
        imageData: imageData,
      ),
    );
  }
}
