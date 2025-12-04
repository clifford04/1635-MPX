import '../models/UserModel.dart';
import 'mock_data_service.dart';

/// Service for user-related operations
class UserService {
  final MockDataService _mockDataService = MockDataService();

  Future<UserModel?> getUserById(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDataService.getUserById(userId);
  }

  Future<List<UserModel>> getFriends(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final user = _mockDataService.getUserById(userId);
    if (user == null) return [];

    return user.friends
        .map((friendId) => _mockDataService.getUserById(friendId))
        .whereType<UserModel>()
        .toList();
  }

  Future<List<UserModel>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDataService.users;
  }
}

