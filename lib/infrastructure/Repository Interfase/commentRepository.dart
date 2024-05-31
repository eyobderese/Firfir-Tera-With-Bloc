import 'package:firfir_tera/Domain/Entities/comment.dart';
import 'package:firfir_tera/infrastructure/services/comment_service.dart';

class CommentRepository {
  final CommentService _commentApi = CommentService();

  Future<List<CommentIncoming>> getComments(String postId) async {
    return await _commentApi.getComments(postId);
  }

  Future<void> addComment(String text, String recipeId) async {
    try {
      await _commentApi.createComment(text, recipeId);
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _commentApi.deleteComment(commentId);
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<void> updateComment(String commentId, String text) async {
    try {
      print("update in repo");
      await _commentApi.updateComment(commentId, text);
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }
}
