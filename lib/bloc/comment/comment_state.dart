import 'package:equatable/equatable.dart';
import 'package:firfir_tera/model/comment.dart';

abstract class CommentState extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentIncoming> comments;

  CommentLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentError extends CommentState {
  final String message;

  CommentError(this.message);

  @override
  List<Object> get props => [message];
}
