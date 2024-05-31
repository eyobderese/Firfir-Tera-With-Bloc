import 'package:firfir_tera/Domain/Entities/profile.dart';
import 'package:firfir_tera/infrastructure/services/authService.dart';
import 'package:firfir_tera/infrastructure/services/profileService.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepository {
  final ProfileService _profileService = ProfileService();

  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required XFile? imageData,
  }) async {
    final String? token = await AuthService().getToken();
    final String? userId = await AuthService().getUserId();

    print(userId);
    print(token);

    try {
      final response = await _profileService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        imageData: imageData,
        token: token!,
        userId: userId!,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProfileModel> getProfile() async {
    final String? token = await AuthService().getToken();
    final String? userId = await AuthService().getUserId();

    try {
      final response = await _profileService.getProfile(userId!, token!);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
