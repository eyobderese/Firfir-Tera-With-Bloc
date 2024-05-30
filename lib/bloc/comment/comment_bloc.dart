import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firfir_tera/model/comment.dart';

import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<LoadComments>(_onLoadComments);
    on<AddComment>(_onAddComment);
  }

  void _onLoadComments(LoadComments event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    print(event.recipeId);

    try {
      // Simulate fetching data
      await Future.delayed(Duration(seconds: 1));

      if (event.recipeId == '1') {
        // Simulate an error for recipeId == '1'
        throw Exception('Failed to load comments');
      }

      List<Comment> comments = []; // Fetch comments from a repository or API
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError('Failed to load comments'));
    }
  }

  void _onAddComment(AddComment event, Emitter<CommentState> emit) {
    final String userId = "";

    if (state is CommentLoaded) {
      final currentState = state as CommentLoaded;
      final List<Comment> updatedComments = List.from(currentState.comments)
        ..add(Comment(
            userId: userId, recipeId: event.recipeId, text: event.content));
      emit(CommentLoaded(updatedComments));
    }
  }
}
