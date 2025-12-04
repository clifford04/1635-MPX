import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_detail_viewmodel.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' show ErrorStateWidget;
import '../widgets/review_card.dart';
import '../services/mock_data_service.dart';

/// Movie detail view showing full movie information, reviews, and actions
class MovieDetailView extends StatefulWidget {
  final String imdbID;

  const MovieDetailView({super.key, required this.imdbID});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  late final MovieDetailViewModel _viewModel;
  final TextEditingController _reviewController = TextEditingController();
  int _selectedRating = 5;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _viewModel = MovieDetailViewModel();
    _viewModel.loadMovieDetails(widget.imdbID);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _showReviewDialog() async {
    int tempRating = _selectedRating;
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Review'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Rating selector with reactive gold/white stars
                      const Text('Rating:'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final rating = index + 1;
                          final isSelected = rating <= tempRating;
                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                tempRating = rating;
                                _selectedRating = rating;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                isSelected ? Icons.star : Icons.star_border,
                                color: isSelected 
                                    ? Colors.amber[700]  // Gold color for filled stars
                                    : Colors.grey[400],  // White/grey for outlined stars
                                size: 40,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      // Comment field
                      TextFormField(
                        controller: _reviewController,
                        decoration: const InputDecoration(
                          labelText: 'Your Review',
                          hintText: 'Write your review here...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a review';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _selectedRating = tempRating;
                      final success = await _viewModel.createReview(
                        rating: tempRating,
                        comment: _reviewController.text.trim(),
                      );
                      
                      if (mounted) {
                        Navigator.of(dialogContext).pop();
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Review added successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          _reviewController.clear();
                          setState(() {
                            _selectedRating = 5;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_viewModel.error ?? 'Failed to add review'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        body: Consumer<MovieDetailViewModel>(
          builder: (context, viewModel, child) {
            // Loading state
            if (viewModel.isLoading && viewModel.movieDetail == null) {
              return const LoadingWidget(message: 'Loading movie details...');
            }

            // Error state
            if (viewModel.hasError && viewModel.movieDetail == null) {
              return Scaffold(
                appBar: AppBar(title: const Text('Movie Details')),
                body: ErrorStateWidget(
                  message: viewModel.error!,
                  onRetry: () => _viewModel.loadMovieDetails(widget.imdbID),
                ),
              );
            }

            final movie = viewModel.movieDetail;
            if (movie == null) {
              return const Scaffold(
                body: Center(child: Text('Movie not found')),
              );
            }

            // Success state
            return CustomScrollView(
              slivers: [
                // App bar with movie poster
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 3,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    background: movie.poster.isNotEmpty &&
                            !movie.poster.startsWith('http')
                        ? Image.asset(
                            movie.poster,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.movie,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          )
                        : movie.poster.startsWith('http')
                            ? Image.network(
                                movie.poster,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(
                                        Icons.movie,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.movie,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                  ),
                ),
                // Movie details
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Year and rating
                        Row(
                          children: [
                            Chip(
                              label: Text(movie.year),
                              backgroundColor: Colors.blue[100],
                            ),
                            if (movie.imdbRating != null) ...[
                              const SizedBox(width: 8),
                              Chip(
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star, size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text('${movie.imdbRating}'),
                                  ],
                                ),
                                backgroundColor: Colors.amber[100],
                              ),
                            ],
                            if (movie.runtime != null) ...[
                              const SizedBox(width: 8),
                              Chip(
                                label: Text(movie.runtime!),
                                backgroundColor: Colors.green[100],
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Plot
                        if (movie.plot != null && movie.plot!.isNotEmpty) ...[
                          Text(
                            'Plot',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.plot!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                        ],
                        // Director
                        if (movie.director != null && movie.director!.isNotEmpty) ...[
                          _buildInfoRow('Director', movie.director!),
                        ],
                        // Actors
                        if (movie.actors != null && movie.actors!.isNotEmpty) ...[
                          _buildInfoRow('Cast', movie.actors!),
                        ],
                        // Genre
                        if (movie.genre != null && movie.genre!.isNotEmpty) ...[
                          _buildInfoRow('Genre', movie.genre!),
                        ],
                        const SizedBox(height: 24),
                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: viewModel.hasUserReviewed
                                    ? null
                                    : () => _showReviewDialog(),
                                icon: const Icon(Icons.rate_review),
                                label: Text(
                                  viewModel.hasUserReviewed
                                      ? 'Already Reviewed'
                                      : 'Add Review',
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: viewModel.isInTopMovies
                                    ? () async {
                                        final success = await viewModel.removeFromTopMovies();
                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                success
                                                    ? 'Removed from Top Movies!'
                                                    : 'Failed to remove from top movies',
                                              ),
                                              backgroundColor:
                                                  success ? Colors.green : Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    : () async {
                                        final success = await viewModel.addToTopMovies();
                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                success
                                                    ? 'Added to Top Movies!'
                                                    : 'Failed to add to top movies',
                                              ),
                                              backgroundColor:
                                                  success ? Colors.green : Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                icon: Icon(
                                  viewModel.isInTopMovies
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                label: Text(
                                  viewModel.isInTopMovies
                                      ? 'Remove from Favorites'
                                      : 'Add to Top Movies',
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor: viewModel.isInTopMovies
                                      ? Colors.grey[600]
                                      : Colors.red[400],
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Reviews section
                        Text(
                          'Reviews (${viewModel.reviews.length})',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                // Reviews list
                if (viewModel.reviews.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text('No reviews yet. Be the first to review!'),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final review = viewModel.reviews[index];
                        final mockData = MockDataService();
                        final user = mockData.getUserById(review.userId);
                        final movie = mockData.getMovieById(review.movieId);
                        return ReviewCard(
                          review: review,
                          user: user,
                          movie: movie,
                        );
                      },
                      childCount: viewModel.reviews.length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

