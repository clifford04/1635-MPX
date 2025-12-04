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
  List<UserModel> _allUsers = [];

  // Immutable getters
  List<ReviewModel> get friendsReviews => List.unmodifiable(_friendsReviews);
  UserModel? get currentUser => _currentUser;
  List<UserModel> get allUsers => List.unmodifiable(_allUsers);

  /// Load friends' reviews for the current user
  Future<void> loadFriendsReviews() async {
    setLoading(true);
    clearError();

    try {
      final currentUserId = _mockDataService.currentUserId;
      _currentUser = await _userService.getUserById(currentUserId);
      _friendsReviews = await _reviewService.getFriendsReviews(currentUserId);
      _allUsers = await _userService.getAllUsers();
    } catch (e) {
      setError('Failed to load friends reviews: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  /// Add a friend
  Future<bool> addFriend(String friendId) async {
    if (_currentUser == null) return false;
    
    setLoading(true);
    clearError();

    try {
      final success = await _userService.addFriend(_currentUser!.id, friendId);
      if (success) {
        // Reload current user and friends reviews
        await loadFriendsReviews();
      }
      return success;
    } catch (e) {
      setError('Failed to add friend: ${e.toString()}');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Remove a friend
  Future<bool> removeFriend(String friendId) async {
    if (_currentUser == null) return false;
    
    setLoading(true);
    clearError();

    try {
      final success = await _userService.removeFriend(_currentUser!.id, friendId);
      if (success) {
        // Reload current user and friends reviews
        await loadFriendsReviews();
      }
      return success;
    } catch (e) {
      setError('Failed to remove friend: ${e.toString()}');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Check if a user is a friend
  bool isFriend(String userId) {
    if (_currentUser == null) return false;
    return _currentUser!.friends.contains(userId);
  }

  /// Refresh friends' reviews
  Future<void> refresh() async {
    await loadFriendsReviews();
  }
}

