import 'package:firfir_tera/Domain/Entities/user.dart';
import 'package:firfir_tera/application/bloc/admin/userDto.dart';
import 'package:firfir_tera/infrastructure/services/profileService.dart';
import 'package:image_picker/image_picker.dart';

class UserRepositoryImp {
  User? _user;

  User getUser() {
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
    required XFile image,
  }) async {
    _user ??= User.empty();
    await Future.delayed(const Duration(seconds: 1));
    _user = _user?.copyWith(
      profileImage: ProfileImage(image: image),
    );
  }

  Future<List<UserDto>> getUserDtoAll() async {
    final ProfileService profileService = ProfileService();

    try {
      final response = await profileService.getAllUsers();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> promoteUser(String userId) async {
    final ProfileService profileService = ProfileService();

    try {
      final response = await profileService.changeRole(userId, 'cook');
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> demoteUser(String userId) async {
    final ProfileService profileService = ProfileService();

    try {
      final response = await profileService.changeRole(userId, 'normal');
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> addAdmin(String userId) async {
    final ProfileService profileService = ProfileService();

    try {
      final response = await profileService.changeRole(userId, 'admin');
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> deleteUser(String userId) async {
    final ProfileService profileService = ProfileService();

    try {
      final response = await profileService.deleteUser(userId);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
