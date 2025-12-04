import '../models/MovieModel.dart';
import '../models/MovieDetailModel.dart';
import '../MovieApi.dart';
import 'mock_data_service.dart';

/// Service for movie-related operations
class MovieService {
  final MovieApi _movieApi = MovieApi();
  final MockDataService _mockDataService = MockDataService();

  /// Fetch movies from API (for search functionality)
  /// Saves movies to MockDataService so they can be retrieved later
  Future<List<MovieModel>> fetchMoviesFromApi(String keyword) async {
    try {
      final movies = await _movieApi.fetchMovies(keyword);
      // Save all fetched movies to MockDataService so they can be retrieved later
      for (final movie in movies) {
        _mockDataService.addOrUpdateMovie(movie);
      }
      return movies;
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

  /// Get detailed movie information by imdbID from API
  /// Saves the basic movie info to MockDataService for later retrieval
  Future<MovieDetailModel> getMovieDetails(String imdbID) async {
    try {
      final movieDetail = await _movieApi.fetchMovieDetails(imdbID);
      // Save the basic movie info so it can be retrieved later
      final movie = MovieModel(
        title: movieDetail.title,
        year: movieDetail.year,
        imdbID: movieDetail.imdbID,
        type: movieDetail.type,
        poster: movieDetail.poster,
      );
      _mockDataService.addOrUpdateMovie(movie);
      return movieDetail;
    } catch (e) {
      // Fallback to basic movie model if API fails
      final movie = await getMovieById(imdbID);
      if (movie != null) {
        return MovieDetailModel(
          title: movie.title,
          year: movie.year,
          imdbID: movie.imdbID,
          type: movie.type,
          poster: movie.poster,
        );
      }
      throw Exception("Movie not found");
    }
  }

  /// Get top movies for a user
  Future<List<MovieModel>> getTopMoviesForUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDataService.getTopMoviesForUser(userId);
  }
}

