import '../models/MovieModel.dart';
import '../MovieApi.dart';
import 'mock_data_service.dart';

/// Service for movie-related operations
class MovieService {
  final MovieApi _movieApi = MovieApi();
  final MockDataService _mockDataService = MockDataService();

  /// Fetch movies from API (for search functionality)
  Future<List<MovieModel>> fetchMoviesFromApi(String keyword) async {
    try {
      return await _movieApi.fetchMovies(keyword);
    } catch (e) {
      // Fallback to mock data if API fails
      return _mockDataService.movies
          .where((movie) =>
              movie.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
  }

  /// Get all movies (from mock data for demo)
  Future<List<MovieModel>> getAllMovies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDataService.movies;
  }

  /// Get movie by ID
  Future<MovieModel?> getMovieById(String movieId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockDataService.getMovieById(movieId);
  }

  /// Get top movies for a user
  Future<List<MovieModel>> getTopMoviesForUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDataService.getTopMoviesForUser(userId);
  }
}

