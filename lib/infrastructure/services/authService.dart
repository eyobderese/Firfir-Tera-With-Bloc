import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
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
      final role = data["role"][0];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('role', role);

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
    await prefs.remove('userId');
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

  Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    return role;
  }

  Future<String?> signUp(String firstName, String lastName, String email,
      String password, String role, String bio, XFile image) async {
    var uri = Uri.parse('$_baseUrl/signup');
    var request = http.MultipartRequest('POST', uri);
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['role'] = role;
    request.fields['bio'] = bio;

    File imageFile = File(image!.path);
    String extension = imageFile.path.split('.').last;
    if (extension != 'jpg' && extension != 'png') {
      throw Exception('The image file must be a jpg or png file');
    }
    var stream = http.ByteStream(image.openRead());
    var length = await image.length();
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: imageFile.path, contentType: MediaType('image', extension));
    request.files.add(multipartFile);
    var response = await http.Response.fromStream(await request.send());
    print(response.statusCode);
    if (response.statusCode == 201) {
      print('User signed up successfully.');
      final data = jsonDecode(response.body);
      final token = data['token'];
      final userId = data["id"];
      final role = data["role"][0];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('role', role);

      return token;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
