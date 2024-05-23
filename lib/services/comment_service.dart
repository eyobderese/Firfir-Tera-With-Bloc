import 'dart:convert';
import 'package:firfir_tera/services/authService.dart';
import 'package:http/http.dart' as http;

class CommentService {
  Future<void> createComment(String text) async {
    final authService = AuthService();
    final userId = await authService.getUserId();
    final response = await http.post(
      Uri.parse('https://your-api-url/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'text': text,
      }),
    );

    if (response.statusCode == 201) {
      // If the server returns a 201 CREATED response,
      // then the comment was successfully created.
      print('Comment created successfully.');
    } else {
      // If the server returns a response with a status code other than 201,
      // then the creation failed.
      throw Exception('Failed to create comment.');
    }
  }
}
