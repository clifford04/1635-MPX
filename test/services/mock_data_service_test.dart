import 'package:flutter_test/flutter_test.dart';
import 'package:mpx1635/services/mock_data_service.dart';

void main() {
  group('MockDataService', () {
    late MockDataService service;

    setUp(() {
      service = MockDataService();
    });

    test('should have at least 5 users', () {
      expect(service.users.length, greaterThanOrEqualTo(5));
    });

    test('should have reviews for users', () {
      expect(service.reviews, isNotEmpty);
    });

    test('should have movies', () {
      expect(service.movies, isNotEmpty);
    });

    test('getUserById should return correct user', () {
      final user = service.getUserById('user1');
      expect(user, isNotNull);
      expect(user?.id, equals('user1'));
    });

    test('getFriendsReviews should return reviews from friends', () {
      final reviews = service.getFriendsReviews('user1');
      expect(reviews, isNotEmpty);
      
      // All reviews should be from friends
      final user = service.getUserById('user1');
      for (final review in reviews) {
        expect(user?.friends, contains(review.userId));
      }
    });

    test('getTopMoviesForUser should return movies', () {
      final movies = service.getTopMoviesForUser('user1');
      expect(movies, isNotEmpty);
    });
  });
}

