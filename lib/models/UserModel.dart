// UserModel doesn't need to import ReviewModel or MovieModel
// They are referenced by ID strings only

class UserModel {
  final String id;
  final String username;
  final List<String> friends; // Changed to List<String> for friend IDs
  final List<String> reviewIds; // Changed to review IDs for better separation
  final String? avatar; // Optional avatar path
  final String? bio; // Optional bio
  final List<String> topMovieIds; // Top movies by ID

  UserModel({
    required this.id,
    required this.username,
    required this.friends,
    required this.reviewIds,
    this.avatar,
    this.bio,
    required this.topMovieIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'friends': friends,
      'reviewIds': reviewIds,
      'avatar': avatar,
      'bio': bio,
      'topMovieIds': topMovieIds,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? "",
      username: json["username"] ?? "",
      friends: json["friends"] != null 
          ? List<String>.from(json["friends"]) 
          : [],
      reviewIds: json["reviewIds"] != null 
          ? List<String>.from(json["reviewIds"]) 
          : (json["reviews"] != null 
              ? List<String>.from(json["reviews"]) 
              : []),
      avatar: json["avatar"],
      bio: json["bio"],
      topMovieIds: json["topMovieIds"] != null 
          ? List<String>.from(json["topMovieIds"]) 
          : [],
    );
  }
}
