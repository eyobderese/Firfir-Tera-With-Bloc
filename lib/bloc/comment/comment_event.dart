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
  final String content;
  final String recipeId;

  AddComment(this.content, this.recipeId);

  @override
  List<Object> get props => [content, recipeId];
}
