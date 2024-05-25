import 'dart:convert';
import 'package:firfir_tera/model/comment.dart';
import 'package:firfir_tera/services/authService.dart';
import 'package:http/http.dart' as http;

class CommentService {
  Future<void> createComment(String text, String recipeId) async {
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

  Future<List<Comment>> getComments(String postId) async {
    final response = await http.get(
      Uri.parse('https://your-api-url/comments?postId=$postId'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON response.
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      // If the server returns a response with a status code other than 200,
      // then the request failed.
      throw Exception('Failed to load comments.');
    }
  }
}

final List<Comment> commentList = [
  Comment(
    text: 'This is a great recipe!',
    userId: '1',
    recipeId: '1',
  ),
  Comment(
    text: 'I love this recipe!',
    userId: '2',
    recipeId: '1',
  ),
  Comment(
    text: 'This recipe is amazing!',
    userId: '3',
    recipeId: '1',
  ),
];
