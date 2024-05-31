import 'package:firfir_tera/Domain/Entities/comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Comment', () {
    test('toJson returns correct map', () {
      final comment = Comment(
        userId: 'user123',
        recipeId: 'recipe123',
        text: 'This is a comment',
        createdAt: DateTime.parse('2022-01-01T12:00:00Z'),
        updatedAt: DateTime.parse('2022-01-02T12:00:00Z'),
      );

      expect(comment.toJson(), {
        'userId': 'user123',
        'recipeId': 'recipe123',
        'text': 'This is a comment',
        'createdAt': '2022-01-01T12:00:00.000Z',
        'updatedAt': '2022-01-02T12:00:00.000Z',
      });
    });

    test('fromJson creates correct instance', () {
      final json = {
        'userId': 'user123',
        'recipeId': 'recipe123',
        'text': 'This is a comment',
        'createdAt': '2022-01-01T12:00:00Z',
        'updatedAt': '2022-01-02T12:00:00Z',
      };

      final comment = Comment.fromJson(json);

      expect(comment.userId, 'user123');
      expect(comment.recipeId, 'recipe123');
      expect(comment.text, 'This is a comment');
      expect(comment.createdAt, DateTime.parse('2022-01-01T12:00:00Z'));
      expect(comment.updatedAt, DateTime.parse('2022-01-02T12:00:00Z'));
    });
  });

  group('UserInComment', () {
    test('fromJson creates correct instance', () {
      final json = {
        '_id': 'user123',
        'firstName': 'John',
        'lastName': 'Doe',
        'image': 'image.png',
      };

      final user = UserInComment.fromJson(json);

      expect(user.id, 'user123');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.image, 'image.png');
    });
  });

  group('CommentIncoming', () {
    test('fromJson creates correct instance', () {
      final json = {
        '_id': 'comment123',
        'userId': {
          '_id': 'user123',
          'firstName': 'John',
          'lastName': 'Doe',
          'image': 'image.png',
        },
        'recipeId': 'recipe123',
        'text': 'This is a comment',
        'createdAt': '2022-01-01T12:00:00Z',
        'updatedAt': '2022-01-02T12:00:00Z',
      };

      final commentIncoming = CommentIncoming.fromJson(json);

      expect(commentIncoming.id, 'comment123');
      expect(commentIncoming.user.id, 'user123');
      expect(commentIncoming.user.firstName, 'John');
      expect(commentIncoming.user.lastName, 'Doe');
      expect(commentIncoming.user.image, 'image.png');
      expect(commentIncoming.recipeId, 'recipe123');
      expect(commentIncoming.text, 'This is a comment');
      expect(commentIncoming.createdAt, DateTime.parse('2022-01-01T12:00:00Z'));
      expect(commentIncoming.updatedAt, DateTime.parse('2022-01-02T12:00:00Z'));
    });
  });
}
