import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ReviewModel.dart';
import '../models/UserModel.dart';
import '../models/MovieModel.dart';
import '../services/mock_data_service.dart';

/// Widget for displaying a review card with animations
class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  final UserModel? user;
  final MovieModel? movie;
  final VoidCallback? onTap;
  final VoidCallback? onUserTap;

  const ReviewCard({
    super.key,
    required this.review,
    this.user,
    this.movie,
    this.onTap,
    this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    final mockData = MockDataService();
    final reviewUser = user ?? mockData.getUserById(review.userId);
    final reviewMovie = movie ?? mockData.getMovieById(review.movieId);

    return Dismissible(
      key: Key(review.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        // Could implement delete functionality here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Review dismissed'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Could restore review here
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          onLongPress: () {
            HapticFeedback.mediumImpact();
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info row
              GestureDetector(
                onTap: onUserTap,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: reviewUser?.avatar != null
                          ? AssetImage(reviewUser!.avatar!)
                          : null,
                      child: reviewUser?.avatar == null
                          ? Text(reviewUser?.username[0].toUpperCase() ?? 'U')
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewUser?.username ?? 'Unknown',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _formatDate(review.createdAt),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Star rating
                    ...List.generate(5, (index) {
                      return Icon(
                        index < review.rating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Movie poster and title
              if (reviewMovie != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'movie_poster_${review.movieId}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: reviewMovie.poster.isNotEmpty &&
                                reviewMovie.poster.startsWith('http')
                            ? Image.network(
                                reviewMovie.poster,
                                width: 60,
                                height: 90,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 60,
                                    height: 90,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 60,
                                    height: 90,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.movie, size: 30),
                                  );
                                },
                              )
                            : Image.asset(
                                reviewMovie.poster,
                                width: 60,
                                height: 90,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 60,
                                    height: 90,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.movie, size: 30),
                                  );
                                },
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewMovie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            reviewMovie.year,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              // Review comment
              Text(
                review.comment,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

