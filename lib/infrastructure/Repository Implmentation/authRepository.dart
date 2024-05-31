import 'package:firfir_tera/Domain/Entities/user.dart';
import 'package:firfir_tera/infrastructure/services/authService.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepositoryImp {
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

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> verifyToken() async {
    try {
      final response = await _authService.verifyToken();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getUserId() async {
    try {
      final userId = await _authService.getUserId();
      return userId;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await _authService.getToken();
      return token;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getRole() async {
    try {
      final role = await _authService.getRole();
      return role;
    } catch (e) {
      throw Exception(e);
    }
  }
}
