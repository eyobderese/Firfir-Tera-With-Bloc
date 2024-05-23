// create a function whicn will fetch the comments
import 'package:firfir_tera/model/comment.dart';

List<Comment> fetchCommentsByRecipeId(String recipeId) {
  return [
    Comment(
      recipeId: '1',
      userId: '1',
      text: 'This is a comment',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Comment(
      recipeId: '1',
      userId: '2',
      text: 'This is another comment',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
}
