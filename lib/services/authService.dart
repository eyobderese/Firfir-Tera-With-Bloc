import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:3000/auth';

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final userId = data["id"];

      print(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('useId', userId);
      return token;
    } else {
      throw Exception(response.body);
    }
  }

  Future<bool> verifyToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return false;

    final response = await http.post(
      Uri.parse('$_baseUrl/verify'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    return response.statusCode == 200;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    return userId;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  Future<void> signUp(String firstName, String lastName, String email,
      String password, String role, String bio) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role,
        'bio': bio,
      }),
    );
    print(role);
    print(jsonDecode(response.body));
    print(response.statusCode);

    if (response.statusCode == 201) {
      print('User signed up successfully.');
    } else {
      throw Exception(response.body);
    }
  }
}
