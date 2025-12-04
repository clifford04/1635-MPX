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
  // Mapping: poster1=Inception, poster2=La La Land, poster3=The Martian, 
  // poster4=Interstellar, poster5=The Dark Knight, poster6=Tenet, 
  // poster7=Frozen, poster8=Moana, poster9=Coco, poster10=Avengers Endgame,
  // poster11=Guardians of the Galaxy, poster12=Doctor Strange, 
  // poster13=Dune, poster14=Oppenheimer, poster15=Grand Budapest Hotel,
  // poster16=The Hunger Games
  // Note: This list is mutable to allow adding movies from API
  final List<MovieModel> _movies = <MovieModel>[
    MovieModel(
      title: "Inception",
      year: "2010",
      imdbID: "tt1375666",
      type: "movie",
      poster: "assets/poster1.jpg",
    ),
    MovieModel(
      title: "La La Land",
      year: "2016",
      imdbID: "tt3783958",
      type: "movie",
      poster: "assets/poster2.jpg",
    ),
    MovieModel(
      title: "The Martian",
      year: "2015",
      imdbID: "tt3659388",
      type: "movie",
      poster: "assets/poster3.jpg",
    ),
    MovieModel(
      title: "Interstellar",
      year: "2014",
      imdbID: "tt0816692",
      type: "movie",
      poster: "assets/poster4.jpg",
    ),
    MovieModel(
      title: "The Dark Knight",
      year: "2008",
      imdbID: "tt0468569",
      type: "movie",
      poster: "assets/poster5.jpg",
    ),
    MovieModel(
      title: "Tenet",
      year: "2020",
      imdbID: "tt6723592",
      type: "movie",
      poster: "assets/poster6.jpg",
    ),
    MovieModel(
      title: "Frozen",
      year: "2013",
      imdbID: "tt2294629",
      type: "movie",
      poster: "assets/poster7.jpg",
    ),
    MovieModel(
      title: "Moana",
      year: "2016",
      imdbID: "tt3521164",
      type: "movie",
      poster: "assets/poster8.jpg",
    ),
    MovieModel(
      title: "Coco",
      year: "2017",
      imdbID: "tt2380307",
      type: "movie",
      poster: "assets/poster9.jpg",
    ),
    MovieModel(
      title: "Avengers: Endgame",
      year: "2019",
      imdbID: "tt4154796",
      type: "movie",
      poster: "assets/poster10.jpg",
    ),
    MovieModel(
      title: "Guardians of the Galaxy",
      year: "2014",
      imdbID: "tt2015381",
      type: "movie",
      poster: "assets/poster11.jpg",
    ),
    MovieModel(
      title: "Doctor Strange",
      year: "2016",
      imdbID: "tt1211837",
      type: "movie",
      poster: "assets/poster12.jpg",
    ),
    MovieModel(
      title: "Dune",
      year: "2021",
      imdbID: "tt1160419",
      type: "movie",
      poster: "assets/poster13.jpg",
    ),
    MovieModel(
      title: "Oppenheimer",
      year: "2023",
      imdbID: "tt15398776",
      type: "movie",
      poster: "assets/poster14.jpg",
    ),
    MovieModel(
      title: "The Grand Budapest Hotel",
      year: "2014",
      imdbID: "tt2278388",
      type: "movie",
      poster: "assets/poster15.jpg",
    ),
    MovieModel(
      title: "The Hunger Games",
      year: "2012",
      imdbID: "tt1392170",
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
        topMovieIds: ["tt1375666", "tt0816692", "tt0468569"], // Inception, Interstellar, The Dark Knight
      ),
      UserModel(
        id: "user2",
        username: "film_critic",
        friends: ["user1", "user3", "user5"],
        reviewIds: ["rev4", "rev5", "rev6", "rev7"],
        bio: "Professional film critic with 10+ years of experience",
        avatar: "assets/friend.png",
        topMovieIds: ["tt6723592", "tt3783958", "tt4154796"], // Tenet, La La Land, Avengers Endgame
      ),
      UserModel(
        id: "user3",
        username: "movie_buff",
        friends: ["user1", "user2", "user4", "user5"],
        reviewIds: ["rev8", "rev9"],
        bio: "Love exploring different genres and hidden gems",
        avatar: "assets/friend.png",
        topMovieIds: ["tt2015381", "tt1211837", "tt3659388"], // Guardians, Doctor Strange, The Martian
      ),
      UserModel(
        id: "user4",
        username: "cinephile_alex",
        friends: ["user1", "user3"],
        reviewIds: ["rev10", "rev11", "rev12"],
        bio: "Documentary filmmaker and movie enthusiast",
        avatar: "assets/friend.png",
        topMovieIds: ["tt1160419", "tt15398776", "tt2278388"], // Dune, Oppenheimer, Grand Budapest Hotel
      ),
      UserModel(
        id: "user5",
        username: "reel_reviewer",
        friends: ["user2", "user3"],
        reviewIds: ["rev13", "rev14", "rev15", "rev16"],
        bio: "Sharing my thoughts on the latest releases",
        avatar: "assets/friend.png",
        topMovieIds: ["tt2294629", "tt3521164", "tt2380307"], // Frozen, Moana, Coco
      ),
    ]);

    // Initialize reviews with timestamps
    // All reviews now use the 16 provided movies with correct titles and posters
    final now = DateTime.now();
    _reviews.addAll([
      // user1 reviews: Inception, Interstellar, The Dark Knight
      ReviewModel(
        id: "rev1",
        rating: 5,
        comment: "Nolan's masterpiece! The concept of dreams within dreams is brilliantly executed. A mind-bending experience.",
        userId: "user1",
        movieId: "tt1375666", // Inception
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      ReviewModel(
        id: "rev2",
        rating: 5,
        comment: "Absolutely stunning visuals and emotional depth. The space sequences are breathtaking and the score is unforgettable.",
        userId: "user1",
        movieId: "tt0816692", // Interstellar
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      ReviewModel(
        id: "rev3",
        rating: 5,
        comment: "Heath Ledger's Joker is iconic. This film redefined what a superhero movie could be. Perfect blend of action and drama.",
        userId: "user1",
        movieId: "tt0468569", // The Dark Knight
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      // user2 reviews: Tenet, La La Land, The Martian, Avengers Endgame
      ReviewModel(
        id: "rev4",
        rating: 4,
        comment: "Complex and visually stunning. Nolan pushes boundaries again with time inversion. Requires multiple viewings to fully appreciate.",
        userId: "user2",
        movieId: "tt6723592", // Tenet
        createdAt: now.subtract(const Duration(hours: 12)),
      ),
      ReviewModel(
        id: "rev5",
        rating: 5,
        comment: "Pure cinematic magic! The musical numbers are beautiful, and the chemistry between Gosling and Stone is electric.",
        userId: "user2",
        movieId: "tt3783958", // La La Land
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      ReviewModel(
        id: "rev6",
        rating: 5,
        comment: "Matt Damon is fantastic as Mark Watney. The perfect blend of science, humor, and survival. A thrilling ride from start to finish.",
        userId: "user2",
        movieId: "tt3659388", // The Martian
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      ReviewModel(
        id: "rev7",
        rating: 5,
        comment: "The perfect conclusion to an epic saga. Emotional, action-packed, and deeply satisfying. The final battle is legendary.",
        userId: "user2",
        movieId: "tt4154796", // Avengers: Endgame
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      // user3 reviews: Guardians of the Galaxy, Doctor Strange
      ReviewModel(
        id: "rev8",
        rating: 5,
        comment: "Fun, quirky, and absolutely hilarious! The soundtrack is perfect, and the characters are instantly lovable. Pure entertainment.",
        userId: "user3",
        movieId: "tt2015381", // Guardians of the Galaxy
        createdAt: now.subtract(const Duration(hours: 6)),
      ),
      ReviewModel(
        id: "rev9",
        rating: 5,
        comment: "Mind-bending visuals and a fantastic origin story. Cumberbatch is perfect as Strange. The magic sequences are breathtaking.",
        userId: "user3",
        movieId: "tt1211837", // Doctor Strange
        createdAt: now.subtract(const Duration(days: 6)),
      ),
      // user4 reviews: Dune, Oppenheimer, Grand Budapest Hotel
      ReviewModel(
        id: "rev10",
        rating: 5,
        comment: "Epic sci-fi done right. The world-building is incredible, and the cinematography is absolutely stunning. Can't wait for part two!",
        userId: "user4",
        movieId: "tt1160419", // Dune
        createdAt: now.subtract(const Duration(hours: 18)),
      ),
      ReviewModel(
        id: "rev11",
        rating: 5,
        comment: "Nolan's masterful storytelling meets historical drama. Cillian Murphy's performance is powerful, and the score is haunting.",
        userId: "user4",
        movieId: "tt15398776", // Oppenheimer
        createdAt: now.subtract(const Duration(days: 8)),
      ),
      ReviewModel(
        id: "rev12",
        rating: 5,
        comment: "Wes Anderson at his finest. Quirky, charming, and beautifully shot. The production design is a work of art.",
        userId: "user4",
        movieId: "tt2278388", // The Grand Budapest Hotel
        createdAt: now.subtract(const Duration(days: 9)),
      ),
      // user5 reviews: Frozen, Moana, Coco, The Hunger Games
      ReviewModel(
        id: "rev13",
        rating: 5,
        comment: "Let it go, let it go! A beautiful story about sisterhood and self-discovery. The songs are absolutely iconic.",
        userId: "user5",
        movieId: "tt2294629", // Frozen
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      ReviewModel(
        id: "rev14",
        rating: 5,
        comment: "Stunning animation and a powerful story about finding your own path. Moana is a fantastic character, and the music is wonderful.",
        userId: "user5",
        movieId: "tt3521164", // Moana
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      ReviewModel(
        id: "rev15",
        rating: 5,
        comment: "Emotional and beautiful. A heartwarming celebration of family and tradition. The animation is vibrant and the music is incredible.",
        userId: "user5",
        movieId: "tt2380307", // Coco
        createdAt: now.subtract(const Duration(days: 11)),
      ),
      ReviewModel(
        id: "rev16",
        rating: 5,
        comment: "Jennifer Lawrence is fantastic as Katniss. A thrilling adaptation with great action sequences and emotional depth.",
        userId: "user5",
        movieId: "tt1392170", // The Hunger Games
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

  // Get movie by ID - returns null if not found instead of first movie
  MovieModel? getMovieById(String movieId) {
    try {
      return movies.firstWhere(
        (movie) => movie.imdbID == movieId,
      );
    } catch (e) {
      return null;
    }
  }

  // Add or update a movie (used when fetching from API)
  void addOrUpdateMovie(MovieModel movie) {
    final index = _movies.indexWhere((m) => m.imdbID == movie.imdbID);
    if (index >= 0) {
      // Update existing movie
      _movies[index] = movie;
    } else {
      // Add new movie
      _movies.add(movie);
    }
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

  // Add a friend to a user
  Future<bool> addFriend(String userId, String friendId) async {
    if (userId == friendId) return false; // Can't add yourself
    
    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return false;
    
    final user = _users[userIndex];
    if (user.friends.contains(friendId)) return false; // Already a friend
    
    // Create new user with added friend
    final updatedUser = UserModel(
      id: user.id,
      username: user.username,
      friends: [...user.friends, friendId],
      reviewIds: user.reviewIds,
      avatar: user.avatar,
      bio: user.bio,
      topMovieIds: user.topMovieIds,
    );
    
    _users[userIndex] = updatedUser;
    return true;
  }

  // Remove a friend from a user
  Future<bool> removeFriend(String userId, String friendId) async {
    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return false;
    
    final user = _users[userIndex];
    if (!user.friends.contains(friendId)) return false; // Not a friend
    
    // Create new user with removed friend
    final updatedUser = UserModel(
      id: user.id,
      username: user.username,
      friends: user.friends.where((id) => id != friendId).toList(),
      reviewIds: user.reviewIds,
      avatar: user.avatar,
      bio: user.bio,
      topMovieIds: user.topMovieIds,
    );
    
    _users[userIndex] = updatedUser;
    return true;
  }

  // Create a new review
  Future<ReviewModel> createReview({
    required String userId,
    required String movieId,
    required int rating,
    required String comment,
  }) async {
    // Generate a unique review ID
    final reviewId = "rev${_reviews.length + 1}";
    
    final review = ReviewModel(
      id: reviewId,
      rating: rating,
      comment: comment,
      userId: userId,
      movieId: movieId,
      createdAt: DateTime.now(),
    );
    
    _reviews.add(review);
    
    // Update user's reviewIds
    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex != -1) {
      final user = _users[userIndex];
      final updatedUser = UserModel(
        id: user.id,
        username: user.username,
        friends: user.friends,
        reviewIds: [...user.reviewIds, reviewId],
        avatar: user.avatar,
        bio: user.bio,
        topMovieIds: user.topMovieIds,
      );
      _users[userIndex] = updatedUser;
    }
    
    return review;
  }

  // Add a movie to user's top movies
  Future<bool> addTopMovie(String userId, String movieId) async {
    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return false;
    
    final user = _users[userIndex];
    if (user.topMovieIds.contains(movieId)) return false; // Already in top movies
    
    // Create new user with added top movie
    final updatedUser = UserModel(
      id: user.id,
      username: user.username,
      friends: user.friends,
      reviewIds: user.reviewIds,
      avatar: user.avatar,
      bio: user.bio,
      topMovieIds: [...user.topMovieIds, movieId],
    );
    
    _users[userIndex] = updatedUser;
    return true;
  }

  // Remove a movie from user's top movies
  Future<bool> removeTopMovie(String userId, String movieId) async {
    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return false;
    
    final user = _users[userIndex];
    if (!user.topMovieIds.contains(movieId)) return false; // Not in top movies
    
    // Create new user with removed top movie
    final updatedUser = UserModel(
      id: user.id,
      username: user.username,
      friends: user.friends,
      reviewIds: user.reviewIds,
      avatar: user.avatar,
      bio: user.bio,
      topMovieIds: user.topMovieIds.where((id) => id != movieId).toList(),
    );
    
    _users[userIndex] = updatedUser;
    return true;
  }
}

