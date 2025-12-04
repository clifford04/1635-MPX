import '../models/ReviewModel.dart';
import '../models/UserModel.dart';
import '../services/review_service.dart';
import '../services/user_service.dart';
import '../services/mock_data_service.dart';
import 'base_viewmodel.dart';

/// ViewModel for the home screen
/// Exposes immutable state for friends' recent reviews
class HomeViewModel extends BaseViewModel {
  final ReviewService _reviewService = ReviewService();
  final UserService _userService = UserService();
  final MockDataService _mockDataService = MockDataService();

  List<ReviewModel> _friendsReviews = [];
  UserModel? _currentUser;

  // Immutable getters
  List<ReviewModel> get friendsReviews => List.unmodifiable(_friendsReviews);
  UserModel? get currentUser => _currentUser;

  /// Load friends' reviews for the current user
  Future<void> loadFriendsReviews() async {
    setLoading(true);
    clearError();

    try {
      final currentUserId = _mockDataService.currentUserId;
      _currentUser = await _userService.getUserById(currentUserId);
      _friendsReviews = await _reviewService.getFriendsReviews(currentUserId);
    } catch (e) {
      setError('Failed to load friends reviews: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  /// Refresh friends' reviews
  Future<void> refresh() async {
    await loadFriendsReviews();
  }
}

