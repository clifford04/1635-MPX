import '../models/ReviewModel.dart';
import 'mock_data_service.dart';

/// Service for review-related operations
class ReviewService {
  final MockDataService _mockDataService = MockDataService();

  Future<List<ReviewModel>> getFriendsReviews(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockDataService.getFriendsReviews(userId);
  }

  Future<List<ReviewModel>> getUserReviews(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDataService.getReviewsByUserId(userId);
  }

  Future<List<ReviewModel>> getMovieReviews(String movieId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDataService.getReviewsByMovieId(movieId);
  }

  /// Create a new review
  Future<ReviewModel> createReview({
    required String userId,
    required String movieId,
    required int rating,
    required String comment,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return await _mockDataService.createReview(
      userId: userId,
      movieId: movieId,
      rating: rating,
      comment: comment,
    );
  }
}

