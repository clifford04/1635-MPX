import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_profile_viewmodel.dart';
import '../widgets/review_card.dart';
import '../widgets/movie_card.dart';
import '../widgets/user_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' show ErrorStateWidget;
import '../widgets/empty_widget.dart';
import '../services/mock_data_service.dart';

/// User profile view showing user's reviews, friends, and top movies
class UserProfileView extends StatefulWidget {
  final String userId;

  const UserProfileView({super.key, required this.userId});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView>
    with SingleTickerProviderStateMixin {
  late final UserProfileViewModel _viewModel;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _viewModel = UserProfileViewModel();
    _tabController = TabController(length: 3, vsync: this);
    _viewModel.loadUserProfile(widget.userId);
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
        body: Consumer<UserProfileViewModel>(
          builder: (context, viewModel, child) {
            // Loading state
            if (viewModel.isLoading && viewModel.user == null) {
              return const Scaffold(
                body: LoadingWidget(message: 'Loading user profile...'),
              );
            }

            // Error state
            if (viewModel.hasError && viewModel.user == null) {
              return Scaffold(
                appBar: AppBar(title: const Text('User Profile')),
                body: ErrorStateWidget(
                  message: viewModel.error!,
                  onRetry: () => _viewModel.loadUserProfile(widget.userId),
                ),
              );
            }

            final user = viewModel.user;
            if (user == null) {
              return const Scaffold(
                body: EmptyWidget(message: 'User not found'),
              );
            }

            // Success state
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 200,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        user.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.deepPurple[400]!,
                              Colors.deepPurple[600]!,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Hero(
                            tag: 'user_avatar_${user.id}',
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: user.avatar != null
                                  ? AssetImage(user.avatar!)
                                  : null,
                              child: user.avatar == null
                                  ? Text(
                                      user.username[0].toUpperCase(),
                                      style: const TextStyle(fontSize: 48),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
                  // Bio section
                  if (user.bio != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        user.bio!,
                        style: TextStyle(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  // Tab bar
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Reviews'),
                      Tab(text: 'Friends'),
                      Tab(text: 'Top Movies'),
                    ],
                  ),
                  // Tab views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Reviews tab
                        _buildReviewsTab(viewModel),
                        // Friends tab
                        _buildFriendsTab(viewModel),
                        // Top Movies tab
                        _buildTopMoviesTab(viewModel),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildReviewsTab(UserProfileViewModel viewModel) {
    if (viewModel.isLoading) {
      return const LoadingWidget();
    }

    if (viewModel.reviews.isEmpty) {
      return const EmptyWidget(
        message: 'No reviews yet',
        icon: Icons.rate_review_outlined,
      );
    }

    final mockData = MockDataService();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: viewModel.reviews.length,
      itemBuilder: (context, index) {
        final review = viewModel.reviews[index];
        final movie = mockData.getMovieById(review.movieId);

        return AnimatedContainer(
          duration: Duration(milliseconds: 200 + (index * 50)),
          curve: Curves.easeOut,
          child: ReviewCard(
            review: review,
            user: viewModel.user,
            movie: movie,
          ),
        );
      },
    );
  }

  Widget _buildFriendsTab(UserProfileViewModel viewModel) {
    if (viewModel.isLoading) {
      return const LoadingWidget();
    }

    if (viewModel.friends.isEmpty) {
      return const EmptyWidget(
        message: 'No friends yet',
        icon: Icons.people_outline,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: viewModel.friends.length,
      itemBuilder: (context, index) {
        final friend = viewModel.friends[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 200 + (index * 50)),
          curve: Curves.easeOut,
          child: UserCard(
            user: friend,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileView(userId: friend.id),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTopMoviesTab(UserProfileViewModel viewModel) {
    if (viewModel.isLoading) {
      return const LoadingWidget();
    }

    if (viewModel.topMovies.isEmpty) {
      return const EmptyWidget(
        message: 'No top movies yet',
        icon: Icons.movie_outlined,
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Increased from 2 to 3 for smaller images
        childAspectRatio: 0.55, // Adjusted for smaller images
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: viewModel.topMovies.length,
      itemBuilder: (context, index) {
        final movie = viewModel.topMovies[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 200 + (index * 100)),
          curve: Curves.easeOut,
          child: MovieCard(movie: movie),
        );
      },
    );
  }
}

