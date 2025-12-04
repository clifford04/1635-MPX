class ReviewModel {
  final String id;
  final int rating; // 1-5 stars
  final String comment;
  final String userId;
  final String movieId;
  final DateTime createdAt; // When the review was created

  ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.userId,
    required this.movieId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'userId': userId,
      'movieId': movieId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json["id"] ?? "",
      rating: json["rating"] ?? 0,
      comment: json["comment"] ?? "",
      userId: json["userId"] ?? "",
      movieId: json["movieId"] ?? "",
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
    );
  }
}