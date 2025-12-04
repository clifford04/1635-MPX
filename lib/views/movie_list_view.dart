import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_list_viewmodel.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' show ErrorStateWidget;
import '../widgets/empty_widget.dart';

/// Movie list view showing all available movies
class MovieListView extends StatefulWidget {
  const MovieListView({super.key});

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  late final MovieListViewModel _viewModel;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = MovieListViewModel();
    _viewModel.loadMovies();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      _viewModel.loadMovies();
    } else {
      _viewModel.searchMovies(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _viewModel.loadMovies();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSubmitted: _performSearch,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _viewModel.loadMovies();
                  }
                },
              ),
            ),
          ),
        ),
        body: Consumer<MovieListViewModel>(
          builder: (context, viewModel, child) {
            // Loading state
            if (viewModel.isLoading && viewModel.movies.isEmpty) {
              return const LoadingWidget(message: 'Loading movies...');
            }

            // Error state
            if (viewModel.hasError && viewModel.movies.isEmpty) {
              return ErrorStateWidget(
                message: viewModel.error!,
                onRetry: () => _viewModel.loadMovies(),
              );
            }

            // Empty state
            if (viewModel.movies.isEmpty) {
              return EmptyWidget(
                message: viewModel.searchQuery.isNotEmpty
                    ? 'No movies found for "${viewModel.searchQuery}"'
                    : 'No movies available',
                icon: Icons.movie_outlined,
              );
            }

            // Success state with pull-to-refresh
            return RefreshIndicator(
              onRefresh: () => _viewModel.refresh(),
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: viewModel.movies.length,
                itemBuilder: (context, index) {
                  final movie = viewModel.movies[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 200 + (index * 50)),
                    curve: Curves.easeOut,
                    child: MovieCard(
                      movie: movie,
                      onTap: () {
                        // Could navigate to movie detail page
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${movie.title} (${movie.year})'),
                            duration: const Duration(seconds: 1),
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

