import 'package:firfir_tera/model/comment.dart';
import 'package:firfir_tera/services/comment_service.dart';

class CommentRepository {
  final CommentService _commentApi = CommentService();

  Future<List<Comment>> getComments(String postId) async {
    return await _commentApi.getComments(postId);
  }

  Future<void> addComment(Comment comment) async {
    await _commentApi.createComment(comment.text, comment.recipeId);
  }
}
