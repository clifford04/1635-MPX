import 'package:flutter_test/flutter_test.dart';
import 'package:mpx1635/viewmodels/home_viewmodel.dart';

void main() {
  group('HomeViewModel', () {
    late HomeViewModel viewModel;

    setUp(() {
      viewModel = HomeViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('initial state should be empty', () {
      expect(viewModel.friendsReviews, isEmpty);
      expect(viewModel.currentUser, isNull);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.hasError, isFalse);
    });

    test('loadFriendsReviews should load reviews successfully', () async {
      await viewModel.loadFriendsReviews();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.hasError, isFalse);
      expect(viewModel.currentUser, isNotNull);
      expect(viewModel.friendsReviews, isNotEmpty);
    });

    test('refresh should reload reviews', () async {
      await viewModel.loadFriendsReviews();
      final initialCount = viewModel.friendsReviews.length;

      await viewModel.refresh();

      expect(viewModel.friendsReviews.length, equals(initialCount));
      expect(viewModel.isLoading, isFalse);
    });
  });
}

