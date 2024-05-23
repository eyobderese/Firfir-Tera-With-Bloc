import 'package:firfir_tera/model/comment.dart';

abstract class CommentEvent {}

class AddCommentEvent extends CommentEvent {
  final Comment comment;

  AddCommentEvent(this.comment);
}
