import '../models/UserModel.dart';
import '../models/ReviewModel.dart';
import '../models/MovieModel.dart';

/// Mock data service that provides example users, reviews, and movies
/// This simulates a backend API for demonstration purposes
class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  // Mock movies using the poster assets
  final List<MovieModel> _movies = [
    MovieModel(
      title: "The Shawshank Redemption",
      year: "1994",
      imdbID: "tt0111161",
      type: "movie",
      poster: "assets/poster1.jpg",
    ),
    MovieModel(
      title: "The Godfather",
      year: "1972",
      imdbID: "tt0068646",
      type: "movie",
      poster: "assets/poster2.jpg",
    ),
    MovieModel(
      title: "The Dark Knight",
      year: "2008",
      imdbID: "tt0468569",
      type: "movie",
      poster: "assets/poster3.jpg",
    ),
    MovieModel(
      title: "Pulp Fiction",
      year: "1994",
      imdbID: "tt0110912",
      type: "movie",
      poster: "assets/poster4.jpg",
    ),
    MovieModel(
      title: "Fight Club",
      year: "1999",
      imdbID: "tt0137523",
      type: "movie",
      poster: "assets/poster5.jpg",
    ),
    MovieModel(
      title: "Inception",
      year: "2010",
      imdbID: "tt1375666",
      type: "movie",
      poster: "assets/poster6.jpg",
    ),
    MovieModel(
      title: "The Matrix",
      year: "1999",
      imdbID: "tt0133093",
      type: "movie",
      poster: "assets/poster7.jpg",
    ),
    MovieModel(
      title: "Goodfellas",
      year: "1990",
      imdbID: "tt0099685",
      type: "movie",
      poster: "assets/poster8.jpg",
    ),
    MovieModel(
      title: "Interstellar",
      year: "2014",
      imdbID: "tt0816692",
      type: "movie",
      poster: "assets/poster9.jpg",
    ),
    MovieModel(
      title: "The Lord of the Rings: The Fellowship",
      year: "2001",
      imdbID: "tt0120737",
      type: "movie",
      poster: "assets/poster10.jpg",
    ),
    MovieModel(
      title: "Forrest Gump",
      year: "1994",
      imdbID: "tt0109830",
      type: "movie",
      poster: "assets/poster11.jpg",
    ),
    MovieModel(
      title: "The Silence of the Lambs",
      year: "1991",
      imdbID: "tt0102926",
      type: "movie",
      poster: "assets/poster12.jpg",
    ),
    MovieModel(
      title: "Saving Private Ryan",
      year: "1998",
      imdbID: "tt0120815",
      type: "movie",
      poster: "assets/poster13.jpg",
    ),
    MovieModel(
      title: "The Green Mile",
      year: "1999",
      imdbID: "tt0120689",
      type: "movie",
      poster: "assets/poster14.jpg",
    ),
    MovieModel(
      title: "Gladiator",
      year: "2000",
      imdbID: "tt0172495",
      type: "movie",
      poster: "assets/poster15.jpg",
    ),
    MovieModel(
      title: "The Departed",
      year: "2006",
      imdbID: "tt0407887",
      type: "movie",
      poster: "assets/poster16.jpg",
    ),
  ];

  // Mock reviews
  final List<ReviewModel> _reviews = [];

  // Mock users
  final List<UserModel> _users = [];

  // Current logged-in user ID (for demo purposes)
  String currentUserId = "user1";

  void _initializeData() {
    // Initialize users
    _users.addAll([
      UserModel(
        id: "user1",
        username: "cinema_lover",
        friends: ["user2", "user3", "user4"],
        reviewIds: ["rev1", "rev2", "rev3"],
        bio: "Passionate about classic cinema and storytelling",
        avatar: "assets/friend.png",
        topMovieIds: ["tt0111161", "tt0068646", "tt0468569"],
      ),
      UserModel(
        id: "user2",
        username: "film_critic",
        friends: ["user1", "user3", "user5"],
        reviewIds: ["rev4", "rev5", "rev6", "rev7"],
        bio: "Professional film critic with 10+ years of experience",
        avatar: "assets/friend.png",
        topMovieIds: ["tt0137523", "tt1375666", "tt0110912"],
      ),
      UserModel(
        id: "user3",
        username: "movie_buff",
        friends: ["user1", "user2", "user4", "user5"],
        reviewIds: ["rev8", "rev9"],
        bio: "Love exploring different genres and hidden gems",
        avatar: "assets/friend.png",
        topMovieIds: ["tt0133093", "tt0099685", "tt0816692"],
      ),
      UserModel(
        id: "user4",
        username: "cinephile_alex",
        friends: ["user1", "user3"],
        reviewIds: ["rev10", "rev11", "rev12"],
        bio: "Documentary filmmaker and movie enthusiast",
        avatar: "assets/friend.png",
        topMovieIds: ["tt0120737", "tt0109830", "tt0102926"],
      ),
      UserModel(
        id: "user5",
        username: "reel_reviewer",
        friends: ["user2", "user3"],
        reviewIds: ["rev13", "rev14", "rev15", "rev16"],
        bio: "Sharing my thoughts on the latest releases",
        avatar: "assets/friend.png",
        topMovieIds: ["tt0120815", "tt0120689", "tt0172495"],
      ),
    ]);

    // Initialize reviews with timestamps
    final now = DateTime.now();
    _reviews.addAll([
      ReviewModel(
        id: "rev1",
        rating: 5,
        comment: "An absolute masterpiece! The storytelling and character development are unparalleled.",
        userId: "user1",
        movieId: "tt0111161",
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      ReviewModel(
        id: "rev2",
        rating: 5,
        comment: "The Godfather remains one of the greatest films ever made. Brando's performance is legendary.",
        userId: "user1",
        movieId: "tt0068646",
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      ReviewModel(
        id: "rev3",
        rating: 5,
        comment: "Heath Ledger's Joker is iconic. This film redefined what a superhero movie could be.",
        userId: "user1",
        movieId: "tt0468569",
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      ReviewModel(
        id: "rev4",
        rating: 4,
        comment: "Fight Club is a mind-bending experience. The twist still gets me every time.",
        userId: "user2",
        movieId: "tt0137523",
        createdAt: now.subtract(const Duration(hours: 12)),
      ),
      ReviewModel(
        id: "rev5",
        rating: 5,
        comment: "Nolan's best work. The concept of dreams within dreams is brilliantly executed.",
        userId: "user2",
        movieId: "tt1375666",
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      ReviewModel(
        id: "rev6",
        rating: 5,
        comment: "Tarantino at his finest. The dialogue, the structure, everything is perfect.",
        userId: "user2",
        movieId: "tt0110912",
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      ReviewModel(
        id: "rev7",
        rating: 4,
        comment: "A great film, though I prefer some of Tarantino's other works.",
        userId: "user2",
        movieId: "tt0110912",
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      ReviewModel(
        id: "rev8",
        rating: 5,
        comment: "The Matrix changed cinema forever. The visual effects were groundbreaking.",
        userId: "user3",
        movieId: "tt0133093",
        createdAt: now.subtract(const Duration(hours: 6)),
      ),
      ReviewModel(
        id: "rev9",
        rating: 5,
        comment: "Scorsese's masterpiece. The long take in the Copacabana is pure cinema.",
        userId: "user3",
        movieId: "tt0099685",
        createdAt: now.subtract(const Duration(days: 6)),
      ),
      ReviewModel(
        id: "rev10",
        rating: 5,
        comment: "Epic fantasy done right. The world-building is incredible.",
        userId: "user4",
        movieId: "tt0120737",
        createdAt: now.subtract(const Duration(hours: 18)),
      ),
      ReviewModel(
        id: "rev11",
        rating: 5,
        comment: "Tom Hanks delivers one of his best performances. A heartwarming story.",
        userId: "user4",
        movieId: "tt0109830",
        createdAt: now.subtract(const Duration(days: 8)),
      ),
      ReviewModel(
        id: "rev12",
        rating: 5,
        comment: "Thrilling and intense. Hopkins as Hannibal Lecter is unforgettable.",
        userId: "user4",
        movieId: "tt0102926",
        createdAt: now.subtract(const Duration(days: 9)),
      ),
      ReviewModel(
        id: "rev13",
        rating: 5,
        comment: "The opening sequence alone is worth the watch. Spielberg's war epic.",
        userId: "user5",
        movieId: "tt0120815",
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      ReviewModel(
        id: "rev14",
        rating: 5,
        comment: "Emotional and powerful. Tom Hanks and Michael Clarke Duncan are incredible.",
        userId: "user5",
        movieId: "tt0120689",
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      ReviewModel(
        id: "rev15",
        rating: 4,
        comment: "Russell Crowe is fantastic. The action sequences are epic.",
        userId: "user5",
        movieId: "tt0172495",
        createdAt: now.subtract(const Duration(days: 11)),
      ),
      ReviewModel(
        id: "rev16",
        rating: 5,
        comment: "One of Scorsese's best. The tension and performances are top-notch.",
        userId: "user5",
        movieId: "tt0407887",
        createdAt: now.subtract(const Duration(hours: 9)),
      ),
    ]);
  }

  // Getters
  List<MovieModel> get movies {
    if (_movies.isEmpty) {
      _initializeData();
    }
    return _movies;
  }

  List<ReviewModel> get reviews {
    if (_reviews.isEmpty) {
      _initializeData();
    }
    return _reviews;
  }

  List<UserModel> get users {
    if (_users.isEmpty) {
      _initializeData();
    }
    return _users;
  }

  // Get user by ID
  UserModel? getUserById(String userId) {
    return users.firstWhere(
      (user) => user.id == userId,
      orElse: () => users.first,
    );
  }

  // Get review by ID
  ReviewModel? getReviewById(String reviewId) {
    return reviews.firstWhere(
      (review) => review.id == reviewId,
      orElse: () => reviews.first,
    );
  }

  // Get movie by ID
  MovieModel? getMovieById(String movieId) {
    return movies.firstWhere(
      (movie) => movie.imdbID == movieId,
      orElse: () => movies.first,
    );
  }

  // Get reviews by user ID
  List<ReviewModel> getReviewsByUserId(String userId) {
    return reviews.where((review) => review.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // Get reviews by movie ID
  List<ReviewModel> getReviewsByMovieId(String movieId) {
    return reviews.where((review) => review.movieId == movieId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // Get friends' reviews (recent reviews from friends)
  List<ReviewModel> getFriendsReviews(String userId) {
    final user = getUserById(userId);
    if (user == null) return [];

    final friendIds = user.friends;
    final friendsReviews = reviews
        .where((review) => friendIds.contains(review.userId))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return friendsReviews;
  }

  // Get top movies for a user (based on their highest rated reviews)
  List<MovieModel> getTopMoviesForUser(String userId) {
    final user = getUserById(userId);
    if (user == null) return [];

    return user.topMovieIds
        .map((movieId) => getMovieById(movieId))
        .whereType<MovieModel>()
        .toList();
  }
}

