
import 'package:bloc_test/bloc_test.dart';
import 'package:firfir_tera/Domain/Repository%20Interface/commentRepository.dart';
import 'package:firfir_tera/application/bloc/comment/comment_bloc.dart';
import 'package:firfir_tera/presentation/pages/comment/bloc/comment_event.dart';
import 'package:firfir_tera/presentation/pages/comment/bloc/comment_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firfir_tera/infrastructure/services/comment_service.dart';

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
  });
}
