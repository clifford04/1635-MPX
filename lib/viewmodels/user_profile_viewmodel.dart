import '../models/UserModel.dart';
import '../models/ReviewModel.dart';
import '../models/MovieModel.dart';
import '../services/user_service.dart';
import '../services/review_service.dart';
import '../services/movie_service.dart';
import 'base_viewmodel.dart';

/// ViewModel for user profile screen
/// Exposes immutable state for user's reviews, friends, and top movies
class UserProfileViewModel extends BaseViewModel {
  final UserService _userService = UserService();
  final ReviewService _reviewService = ReviewService();
  final MovieService _movieService = MovieService();

  UserModel? _user;
  List<ReviewModel> _reviews = [];
  List<UserModel> _friends = [];
  List<MovieModel> _topMovies = [];

  // Immutable getters
  UserModel? get user => _user;
  List<ReviewModel> get reviews => List.unmodifiable(_reviews);
  List<UserModel> get friends => List.unmodifiable(_friends);
  List<MovieModel> get topMovies => List.unmodifiable(_topMovies);

  /// Load user profile data
  Future<void> loadUserProfile(String userId) async {
    setLoading(true);
    clearError();

    try {
      // Load user data
      _user = await _userService.getUserById(userId);
      if (_user == null) {
        setError('User not found');
        return;
      }

      // Load related data in parallel
      await Future.wait([
        _loadReviews(),
        _loadFriends(),
        _loadTopMovies(),
      ]);
    } catch (e) {
      setError('Failed to load user profile: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> _loadReviews() async {
    if (_user == null) return;
    _reviews = await _reviewService.getUserReviews(_user!.id);
  }

  Future<void> _loadFriends() async {
    if (_user == null) return;
    _friends = await _userService.getFriends(_user!.id);
  }

  Future<void> _loadTopMovies() async {
    if (_user == null) return;
    _topMovies = await _movieService.getTopMoviesForUser(_user!.id);
  }

  /// Refresh user profile
  Future<void> refresh(String userId) async {
    await loadUserProfile(userId);
  }
}

