import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/review_card.dart';
import '../widgets/user_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' show ErrorStateWidget;
import '../widgets/empty_widget.dart';
import '../services/mock_data_service.dart';
import 'user_profile_view.dart';

/// Home view showing recent reviews from friends and friend management
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late final HomeViewModel _viewModel;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _tabController = TabController(length: 2, vsync: this);
    _viewModel.loadFriendsReviews();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _tabController.dispose();
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
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Reviews', icon: Icon(Icons.rate_review)),
              Tab(text: 'Friends', icon: Icon(Icons.people)),
            ],
          ),
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return TabBarView(
              controller: _tabController,
              children: [
                // Reviews tab
                _buildReviewsTab(viewModel),
                // Friends tab
                _buildFriendsTab(viewModel),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildReviewsTab(HomeViewModel viewModel) {
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
  }

  Widget _buildFriendsTab(HomeViewModel viewModel) {
    final currentUser = viewModel.currentUser;
    if (currentUser == null) {
      return const LoadingWidget(message: 'Loading...');
    }

    // Loading state
    if (viewModel.isLoading && viewModel.allUsers.isEmpty) {
      return const LoadingWidget(message: 'Loading users...');
    }

    // Error state
    if (viewModel.hasError && viewModel.allUsers.isEmpty) {
      return ErrorStateWidget(
        message: viewModel.error!,
        onRetry: () => _viewModel.loadFriendsReviews(),
      );
    }

    // Filter out current user
    final otherUsers = viewModel.allUsers
        .where((user) => user.id != currentUser.id)
        .toList();

    if (otherUsers.isEmpty) {
      return const EmptyWidget(
        message: 'No other users found',
        icon: Icons.people_outline,
      );
    }

    return RefreshIndicator(
      onRefresh: () => _viewModel.refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: otherUsers.length,
        itemBuilder: (context, index) {
          final user = otherUsers[index];
          final isFriend = viewModel.isFriend(user.id);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: user.avatar != null
                      ? AssetImage(user.avatar!)
                      : null,
                  child: user.avatar == null
                      ? Text(user.username[0].toUpperCase())
                      : null,
                ),
                title: Text(user.username),
                subtitle: user.bio != null ? Text(user.bio!) : null,
                trailing: isFriend
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          final success = await viewModel.removeFriend(user.id);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? 'Removed ${user.username} from friends'
                                      : 'Failed to remove friend',
                                ),
                                backgroundColor:
                                    success ? Colors.green : Colors.red,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.person_remove, size: 18),
                        label: const Text('Remove'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () async {
                          final success = await viewModel.addFriend(user.id);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? 'Added ${user.username} as friend'
                                      : 'Failed to add friend',
                                ),
                                backgroundColor:
                                    success ? Colors.green : Colors.red,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.person_add, size: 18),
                        label: const Text('Add'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          foregroundColor: Colors.white,
                        ),
                      ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileView(userId: user.id),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

