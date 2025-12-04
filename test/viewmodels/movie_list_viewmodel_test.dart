import 'package:flutter_test/flutter_test.dart';
import 'package:mpx1635/viewmodels/movie_list_viewmodel.dart';

void main() {
  group('MovieListViewModel', () {
    late MovieListViewModel viewModel;

    setUp(() {
      viewModel = MovieListViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('initial state should be empty', () {
      expect(viewModel.movies, isEmpty);
      expect(viewModel.searchQuery, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.hasError, isFalse);
    });

    test('loadMovies should load movies successfully', () async {
      await viewModel.loadMovies();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.hasError, isFalse);
      expect(viewModel.movies, isNotEmpty);
    });

    test('searchMovies should update search query', () async {
      const query = 'test';
      await viewModel.searchMovies(query);

      expect(viewModel.searchQuery, equals(query));
    });

    test('refresh should reload movies', () async {
      await viewModel.loadMovies();
      final initialCount = viewModel.movies.length;

      await viewModel.refresh();

      expect(viewModel.movies.length, equals(initialCount));
      expect(viewModel.isLoading, isFalse);
    });
  });
}

