class Comment {
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
}
