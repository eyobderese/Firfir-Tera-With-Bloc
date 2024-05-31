import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String userId;
  final String recipeId;
  final String text;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Comment({
    required this.userId,
    required this.recipeId,
    required this.text,
    this.createdAt,
    this.updatedAt,
  });

  // Convert a Comment instance into a Map for JSON serialization
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'recipeId': recipeId,
        'text': text,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  // Create a Comment instance from a Map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'],
      recipeId: json['recipeId'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [userId, recipeId, text, createdAt, updatedAt];
}

class UserInComment {
  final String id;
  final String firstName;
  final String lastName;
  final String image;

  UserInComment({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory UserInComment.fromJson(Map<String, dynamic> json) {
    return UserInComment(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
    );
  }
}

class CommentIncoming {
  final String id;
  final UserInComment user;
  final String recipeId;
  final String text;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CommentIncoming({
    required this.id,
    required this.user,
    required this.recipeId,
    required this.text,
    this.createdAt,
    this.updatedAt,
  });

  factory CommentIncoming.fromJson(Map<String, dynamic> json) {
    return CommentIncoming(
      id: json['_id'],
      user: UserInComment.fromJson(json['userId']),
      recipeId: json['recipeId'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
