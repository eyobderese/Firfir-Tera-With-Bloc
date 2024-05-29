import 'dart:convert';
import 'package:firfir_tera/model/comment.dart';
import 'package:firfir_tera/services/authService.dart';
import 'package:http/http.dart' as http;

class CommentService {
  final String baseUrl = 'http://10.0.2.2:3000/comments';
  Future<void> createComment(String text, String recipeId) async {
    print("text $text");
    final authService = AuthService();
    final userId = await authService.getUserId();
    final response = await http.post(
      Uri.parse(baseUrl + '/' + recipeId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'comment': text,
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

  Future<List<CommentIncoming>> getComments(String postId) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + '/' + postId),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("hi");
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CommentIncoming.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch comments');
      }
    } catch (e) {
      throw Exception('Failed to fetch comments out');
    }
  }

  Future<void> deleteComment(String commentId) async {
    final response = await http.delete(
      Uri.parse(baseUrl + '/' + commentId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then the comment was successfully deleted.
      print('Comment deleted successfully.');
    } else {
      // If the server returns a response with a status code other than 200,
      // then the deletion failed.
      throw Exception('Failed to delete comment.');
    }
  }

  Future<void> updateComment(String commentId, String text) async {
    print(text);
    final response = await http.patch(
      Uri.parse(baseUrl + '/' + commentId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'comment': text,
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then the comment was successfully updated.
      print('Comment updated successfully.');
    } else {
      // If the server returns a response with a status code other than 200,
      // then the update failed.
      throw Exception('Failed to update comment.');
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
