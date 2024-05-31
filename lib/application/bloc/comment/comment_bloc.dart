import 'package:bloc/bloc.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/commentRepository.dart';
import 'package:firfir_tera/Domain/Entities/comment.dart';
import 'package:firfir_tera/infrastructure/services/comment_service.dart';

import '../../../presentation/pages/comment/bloc/comment_event.dart';
import '../../../presentation/pages/comment/bloc/comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository = CommentRepository();

  CommentBloc() : super(CommentInitial()) {
    on<LoadComments>(_onLoadComments);
    on<AddComment>(_onAddComment);
    on<DeleteComment>(_onDeleteComment);
    on<UpdateComment>(_onUpdateComment);
  }

  void _onLoadComments(LoadComments event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    print(event.recipeId);

    try {
      // Simulate fetching data

      List<CommentIncoming> comments = await _commentRepository.getComments(
          event.recipeId); // Fetch comments from a repository or API
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError('Failed to load comments'));
    }
  }

  void _onAddComment(AddComment event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      try {
        // Send the new comment in a POST request
        // Replace this with your actual POST request code
        await _commentRepository.addComment(event.text, event.recipeId);

        // Fetch the updated list of comments
        // Replace this with your actual fetch comments code
        final updatedComments =
            await _commentRepository.getComments(event.recipeId);

        emit(CommentLoaded(updatedComments));
      } catch (e) {
        emit(CommentError('Failed to add comment'));
      }
    }
  }

  void _onDeleteComment(DeleteComment event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      try {
        // Send a DELETE request to delete the comment
        // Replace this with your actual DELETE request code
        await _commentRepository.deleteComment(event.commentId);

        // Fetch the updated list of comments
        // Replace this with your actual fetch comments code
        final updatedComments =
            await _commentRepository.getComments(event.recipeId);

        emit(CommentLoaded(updatedComments));
      } catch (e) {
        emit(CommentError('Failed to delete comment'));
      }
    }
  }

  void _onUpdateComment(UpdateComment event, Emitter<CommentState> emit) async {
    print(state is CommentLoaded);

    try {
      // Send a PATCH request to update the comment
      // Replace this with your actual PATCH request code
      await _commentRepository.updateComment(event.commentId, event.text);

      // Fetch the updated list of comments
      // Replace this with your actual fetch comments code
      final updatedComments =
          await _commentRepository.getComments(event.recipeId);

      emit(CommentLoaded(updatedComments));
    } catch (e) {
      emit(CommentError('Failed to update comment'));
    }
  }
}
