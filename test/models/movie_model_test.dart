import 'package:flutter_test/flutter_test.dart';
import 'package:mpx1635/models/MovieModel.dart';

void main() {
  group('MovieModel', () {
    test('fromJson should create MovieModel correctly', () {
      final json = {
        'Title': 'The Shawshank Redemption',
        'Year': '1994',
        'imdbID': 'tt0111161',
        'Type': 'movie',
        'Poster': 'assets/poster1.jpg',
      };

      final movie = MovieModel.fromJson(json);

      expect(movie.title, equals('The Shawshank Redemption'));
      expect(movie.year, equals('1994'));
      expect(movie.imdbID, equals('tt0111161'));
      expect(movie.type, equals('movie'));
      expect(movie.poster, equals('assets/poster1.jpg'));
    });

    test('fromJson should handle missing fields with defaults', () {
      final json = {
        'Title': 'Test Movie',
      };

      final movie = MovieModel.fromJson(json);

      expect(movie.title, equals('Test Movie'));
      expect(movie.year, equals('Unknown Year'));
      expect(movie.imdbID, isEmpty);
      expect(movie.type, equals('movie'));
      expect(movie.poster, isEmpty);
    });
  });
}

