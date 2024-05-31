import 'dart:convert';

import 'package:firfir_tera/application/bloc/admin/userDto.dart';
import 'package:firfir_tera/Domain/Entities/profile.dart';
import 'package:firfir_tera/infrastructure/services/authService.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ProfileService {
  Future<ProfileModel> getProfile(String userId, String token) async {
    const String _baseUrl = 'http://10.0.2.2:3000/user';

    print(userId);
    print(token);
    final response = await http.get(
      Uri.parse('$_baseUrl/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProfileModel.fromJson(data);
    } else {
      throw Exception('Failed to load profile');
    }
  }

// upload has multipart request with image file
  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    XFile? imageData,
    required String token,
    required String userId,
  }) async {
    const String _baseUrl = 'http://10.0.2.2:3000/user';

    var request =
        http.MultipartRequest('PATCH', Uri.parse('$_baseUrl/$userId'));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['email'] = email;

    if (imageData != null) {
      var imageFile = imageData;
      String extension = imageFile.path.split('.').last;
      if (extension != 'jpg' && extension != 'png') {
        throw Exception('The image file must be a jpg or png file');
      }
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: imageFile.path.split('/').last,
          contentType: MediaType('image', extension));
      request.files.add(multipartFile);
    }

    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase);

    if (response.statusCode == 200) {
      return ('Profile updated successfully');
    } else {
      throw Exception(
          'Failed to update profile Status code: ${response.statusCode}');
    }
  }

  Future<List<UserDto>> getAllUsers() async {
    try {
      final String? token = await AuthService().getToken();
      const String _baseUrl = 'http://10.0.2.2:3000/user';
      final response = await http.get(
        Uri.parse('$_baseUrl'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => UserDto.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<String> changeRole(String userId, String role) async {
    print("user is promoted/demoted with id $userId");

    final String? token = await AuthService().getToken();
    const String _baseUrl = 'http://10.0.2.2:3000/user';
    final response = await http.patch(
      Uri.parse('$_baseUrl'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'role': role,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return ('Role changed successfully');
    } else {
      throw Exception('Failed to change role');
    }
  }

  Future<String> deleteUser(String userId) async {
    try {
      print("user is deleted with id $userId");
      final String? token = await AuthService().getToken();
      const String _baseUrl = 'http://10.0.2.2:3000/user/';
      final response = await http.delete(
        Uri.parse('$_baseUrl$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("hi");

      print(response.statusCode);
      if (response.statusCode == 200) {
        return ('Deleted successfully');
      } else {
        throw Exception('Failed to Delete');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
