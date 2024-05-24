import 'package:firfir_tera/model/user.dart';
import 'package:firfir_tera/services/authService.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<String?> login(String username, String password) async {
    try {
      final respons = await _authService.login(username, password);
      return respons;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signup(String firstName, String lastName, String email,
      String password, String role, String bio, XFile image) async {
    try {
      await _authService.signUp(
          firstName, lastName, email, password, role, bio, image);
    } catch (e) {
      throw Exception(e);
    }
  }
}
