import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadComments extends CommentEvent {
  final String recipeId;

  LoadComments({required this.recipeId});

  @override
  List<Object> get props => [recipeId];
}

class AddComment extends CommentEvent {
  final String text;
  final String recipeId;

  AddComment(this.text, this.recipeId);

  @override
  List<Object> get props => [text, recipeId];
}

class DeleteComment extends CommentEvent {
  final String commentId;
  final String recipeId;

  DeleteComment(this.commentId, this.recipeId);

  @override
  List<Object> get props => [commentId, recipeId];
}

class UpdateComment extends CommentEvent {
  final String commentId;
  final String text;
  final String recipeId;

  UpdateComment(this.commentId, this.text, this.recipeId);

  @override
  List<Object> get props => [commentId, text];
}
