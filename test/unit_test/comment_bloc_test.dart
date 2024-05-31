import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/Repository/commentRepository.dart';
import 'package:firfir_tera/bloc/comment/comment_bloc.dart';
import 'package:firfir_tera/bloc/comment/comment_event.dart';
import 'package:firfir_tera/bloc/comment/comment_state.dart';
import 'package:firfir_tera/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firfir_tera/services/comment_service.dart';

@GenerateMocks([CommentService, CommentRepository])
import 'mocks/comment_bloc_test.mocks.dart';

void main() {
  group('CommentBloc', () {
    late CommentBloc commentBloc;
    late MockCommentRepository mockCommentRepository;

    setUp(() {
      mockCommentRepository = MockCommentRepository();
      commentBloc = CommentBloc();
    });

    tearDown(() {
      commentBloc.close();
    });

    test('initial state is CommentInitial', () {
      expect(commentBloc.state, CommentInitial());
    });

    blocTest<CommentBloc, CommentState>(
      'emits [CommentLoading, CommentLoaded] when LoadComments is added',
      build: () {
        when(mockCommentRepository.getComments('2'))
            .thenAnswer((_) async => []); 
        return commentBloc;
      },
      act: (bloc) async {
        bloc.add(LoadComments(recipeId: '2'));
        await Future.delayed(const Duration(milliseconds: 1600));
      },
      expect: () => [
        CommentLoading(),
        CommentLoaded([]),
      ],
    );

   blocTest<CommentBloc, CommentState>(
      'emits [CommentLoading, CommentError] when LoadComments fails',
      build: () {
        when(mockCommentRepository.getComments('1'))
            .thenThrow(Exception('Failed to load comments'));
        return commentBloc;
      },
      act: (bloc) async {
        bloc.add(LoadComments(recipeId: '1'));
        await expectLater(
            bloc.stream,
            emitsInOrder([
              CommentLoading(),
              CommentError('Failed to load comments'),
            ]));
      },
      expect: () => [
        CommentLoading(),
        CommentError('Failed to load comments'),
      ],
    );

    blocTest<CommentBloc, CommentState>(
      'emits [CommentLoaded] with updated comments when AddComment is added',
      build: () {
        return commentBloc;
      },
      act: (bloc) async{
        bloc.add(LoadComments(recipeId: '2'));
        await Future.delayed(const Duration(milliseconds: 1600));
        bloc.add(AddComment('New Comment', '2'));
        await Future.delayed(const Duration(milliseconds: 1600));
      },
      expect: () => [
        CommentLoading(),
        CommentLoaded([]),
        CommentLoaded(
            [Comment(userId: '', recipeId: '2', text: 'New Comment')]),
      ],
    );
  });
}


