import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/review_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' show ErrorStateWidget;
import '../widgets/empty_widget.dart';
import '../services/mock_data_service.dart';
import 'user_profile_view.dart';

/// Home view showing recent reviews from friends
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.loadFriendsReviews();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MPX'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _viewModel.refresh(),
              tooltip: 'Refresh',
            ),
          ],
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            // Loading state
            if (viewModel.isLoading && viewModel.friendsReviews.isEmpty) {
              return const LoadingWidget(message: 'Loading friends reviews...');
            }

            // Error state
            if (viewModel.hasError && viewModel.friendsReviews.isEmpty) {
              return ErrorStateWidget(
                message: viewModel.error!,
                onRetry: () => _viewModel.loadFriendsReviews(),
              );
            }

            // Empty state
            if (viewModel.friendsReviews.isEmpty) {
              return const EmptyWidget(
                message: 'No reviews from friends yet.\nStart following people to see their reviews!',
                icon: Icons.people_outline,
              );
            }

            // Success state with pull-to-refresh
            return RefreshIndicator(
              onRefresh: () => _viewModel.refresh(),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: viewModel.friendsReviews.length,
                itemBuilder: (context, index) {
                  final review = viewModel.friendsReviews[index];
                  final mockData = MockDataService();
                  final user = mockData.getUserById(review.userId);
                  final movie = mockData.getMovieById(review.movieId);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: ReviewCard(
                      review: review,
                      user: user,
                      movie: movie,
                      onUserTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileView(userId: review.userId),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

