import '../models/MovieModel.dart';
import '../services/movie_service.dart';
import 'base_viewmodel.dart';

/// ViewModel for movie list screen
/// Exposes immutable state for list of movies
class MovieListViewModel extends BaseViewModel {
  final MovieService _movieService = MovieService();

  List<MovieModel> _movies = [];
  String _searchQuery = '';

  // Immutable getters
  List<MovieModel> get movies => List.unmodifiable(_movies);
  String get searchQuery => _searchQuery;

  /// Load all movies
  Future<void> loadMovies() async {
    setLoading(true);
    clearError();

    try {
      _movies = await _movieService.getAllMovies();
    } catch (e) {
      setError('Failed to load movies: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  /// Search movies by keyword
  Future<void> searchMovies(String keyword) async {
    if (keyword.isEmpty) {
      await loadMovies();
      return;
    }

    setLoading(true);
    clearError();
    _searchQuery = keyword;

    try {
      _movies = await _movieService.fetchMoviesFromApi(keyword);
      if (_movies.isEmpty) {
        setError('No movies found for "$keyword"');
      }
    } catch (e) {
      setError('Failed to search movies: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  /// Refresh movies list
  Future<void> refresh() async {
    await loadMovies();
  }
}

