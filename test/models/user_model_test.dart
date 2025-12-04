import 'package:flutter_test/flutter_test.dart';
import 'package:mpx1635/models/UserModel.dart';

void main() {
  group('UserModel', () {
    test('fromJson should create UserModel correctly', () {
      final json = {
        'id': 'user1',
        'username': 'testuser',
        'friends': ['user2', 'user3'],
        'reviewIds': ['rev1', 'rev2'],
        'bio': 'Test bio',
        'avatar': 'assets/friend.png',
        'topMovieIds': ['tt0111161', 'tt0068646'],
      };

      final user = UserModel.fromJson(json);

      expect(user.id, equals('user1'));
      expect(user.username, equals('testuser'));
      expect(user.friends.length, equals(2));
      expect(user.reviewIds.length, equals(2));
      expect(user.bio, equals('Test bio'));
      expect(user.avatar, equals('assets/friend.png'));
      expect(user.topMovieIds.length, equals(2));
    });

    test('toJson should serialize UserModel correctly', () {
      final user = UserModel(
        id: 'user1',
        username: 'testuser',
        friends: ['user2'],
        reviewIds: ['rev1'],
        bio: 'Test bio',
        avatar: 'assets/friend.png',
        topMovieIds: ['tt0111161'],
      );

      final json = user.toJson();

      expect(json['id'], equals('user1'));
      expect(json['username'], equals('testuser'));
      expect(json['friends'], isA<List>());
      expect(json['reviewIds'], isA<List>());
    });
  });
}

