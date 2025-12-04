import '../models/MovieDetailModel.dart';
import '../models/MovieModel.dart';
import '../models/ReviewModel.dart';
import '../services/movie_service.dart';
import '../services/review_service.dart';
import '../services/user_service.dart';
import '../services/mock_data_service.dart';
import 'base_viewmodel.dart';

/// ViewModel for movie detail screen
/// Exposes immutable state for movie details, reviews, and user actions
class MovieDetailViewModel extends BaseViewModel {
  final MovieService _movieService = MovieService();
  final ReviewService _reviewService = ReviewService();
  final UserService _userService = UserService();
  final MockDataService _mockDataService = MockDataService();

  MovieDetailModel? _movieDetail;
  List<ReviewModel> _reviews = [];
  bool _isInTopMovies = false;
  bool _hasUserReviewed = false;

  // Immutable getters
  MovieDetailModel? get movieDetail => _movieDetail;
  List<ReviewModel> get reviews => List.unmodifiable(_reviews);
  bool get isInTopMovies => _isInTopMovies;
  bool get hasUserReviewed => _hasUserReviewed;

  /// Load movie details by imdbID
  Future<void> loadMovieDetails(String imdbID) async {
    setLoading(true);
    clearError();

    try {
      _movieDetail = await _movieService.getMovieDetails(imdbID);
      await Future.wait([
        _loadReviews(imdbID),
        _checkTopMoviesStatus(imdbID),
        _checkReviewStatus(imdbID),
      ]);
    } catch (e) {
      setError('Failed to load movie details: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> _loadReviews(String movieId) async {
    _reviews = await _reviewService.getMovieReviews(movieId);
  }

  Future<void> _checkTopMoviesStatus(String movieId) async {
    final currentUserId = _mockDataService.currentUserId;
    final user = await _userService.getUserById(currentUserId);
    if (user != null) {
      _isInTopMovies = user.topMovieIds.contains(movieId);
    }
  }

  Future<void> _checkReviewStatus(String movieId) async {
    final currentUserId = _mockDataService.currentUserId;
    final userReviews = await _reviewService.getUserReviews(currentUserId);
    _hasUserReviewed = userReviews.any((review) => review.movieId == movieId);
  }

  /// Create a review for this movie
  /// Ensures movie details are saved before creating review
  Future<bool> createReview({
    required int rating,
    required String comment,
  }) async {
    if (_movieDetail == null) return false;
    if (rating < 1 || rating > 5) return false;
    if (comment.trim().isEmpty) return false;

    setLoading(true);
    clearError();

    try {
      // Ensure movie is saved to MockDataService before creating review
      // This ensures the movie can be retrieved later when displaying reviews
      final movie = MovieModel(
        title: _movieDetail!.title,
        year: _movieDetail!.year,
        imdbID: _movieDetail!.imdbID,
        type: _movieDetail!.type,
        poster: _movieDetail!.poster,
      );
      _mockDataService.addOrUpdateMovie(movie);

      final currentUserId = _mockDataService.currentUserId;
      await _reviewService.createReview(
        userId: currentUserId,
        movieId: _movieDetail!.imdbID,
        rating: rating,
        comment: comment,
      );
      
      // Reload reviews and check review status
      await Future.wait([
        _loadReviews(_movieDetail!.imdbID),
        _checkReviewStatus(_movieDetail!.imdbID),
      ]);
      
      return true;
    } catch (e) {
      setError('Failed to create review: ${e.toString()}');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Add movie to top movies
  Future<bool> addToTopMovies() async {
    if (_movieDetail == null) return false;
    if (_isInTopMovies) return false;

    setLoading(true);
    clearError();

    try {
      final currentUserId = _mockDataService.currentUserId;
      final success = await _userService.addTopMovie(
        currentUserId,
        _movieDetail!.imdbID,
      );
      
      if (success) {
        _isInTopMovies = true;
      }
      
      return success;
    } catch (e) {
      setError('Failed to add to top movies: ${e.toString()}');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Remove movie from top movies
  Future<bool> removeFromTopMovies() async {
    if (_movieDetail == null) return false;
    if (!_isInTopMovies) return false;

    setLoading(true);
    clearError();

    try {
      final currentUserId = _mockDataService.currentUserId;
      final success = await _userService.removeTopMovie(
        currentUserId,
        _movieDetail!.imdbID,
      );
      
      if (success) {
        _isInTopMovies = false;
      }
      
      return success;
    } catch (e) {
      setError('Failed to remove from top movies: ${e.toString()}');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Refresh movie details
  Future<void> refresh(String imdbID) async {
    await loadMovieDetails(imdbID);
  }
}

