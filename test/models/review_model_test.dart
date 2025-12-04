import 'package:flutter_test/flutter_test.dart';
import 'package:mpx1635/models/ReviewModel.dart';

void main() {
  group('ReviewModel', () {
    test('fromJson should create ReviewModel correctly', () {
      final json = {
        'id': 'rev1',
        'rating': 5,
        'comment': 'Great movie!',
        'userId': 'user1',
        'movieId': 'tt0111161',
        'createdAt': '2024-01-01T00:00:00.000Z',
      };

      final review = ReviewModel.fromJson(json);

      expect(review.id, equals('rev1'));
      expect(review.rating, equals(5));
      expect(review.comment, equals('Great movie!'));
      expect(review.userId, equals('user1'));
      expect(review.movieId, equals('tt0111161'));
      expect(review.createdAt, isA<DateTime>());
    });

    test('toJson should serialize ReviewModel correctly', () {
      final review = ReviewModel(
        id: 'rev1',
        rating: 5,
        comment: 'Great movie!',
        userId: 'user1',
        movieId: 'tt0111161',
        createdAt: DateTime(2024, 1, 1),
      );

      final json = review.toJson();

      expect(json['id'], equals('rev1'));
      expect(json['rating'], equals(5));
      expect(json['comment'], equals('Great movie!'));
      expect(json['userId'], equals('user1'));
      expect(json['movieId'], equals('tt0111161'));
      expect(json['createdAt'], isA<String>());
    });
  });
}

