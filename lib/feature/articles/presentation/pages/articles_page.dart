import 'package:flightnews/feature/articles/presentation/provider/articles_provider.dart';
import 'package:flightnews/feature/articles/presentation/widget/articles_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Page untuk menampilkan daftar articles dengan pagination
class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Space Flight News'), elevation: 0),
      body: Consumer<ArticlesProvider>(
        builder: (context, provider, child) {
          // Loading state - first time load
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (provider.errorMessage != null) {
            return _buildErrorWidget(context, provider);
          }

          // No data state
          if (provider.articles == null || provider.articles!.results.isEmpty) {
            return const Center(child: Text('No articles found'));
          }

          // Success state - show articles list
          return RefreshIndicator(
            onRefresh: () => provider.getArticles(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Articles',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total: ${provider.articles!.count} articles',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (provider.hasNextPage)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Scroll to load more',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Articles list dengan pagination
                  ArticlesListWidget(
                    articles: provider.articles!.results,
                    isLoadingMore: provider.isLoadingMore,
                    hasNextPage: provider.hasNextPage,
                    onLoadMore: () =>
                        provider.getMoreArticles(provider.nextUrl!),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          provider.getMoreArticles(provider.nextUrl!);
                        },
                        child: const Icon(Icons.keyboard_double_arrow_down),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build error widget dengan retry button
  Widget _buildErrorWidget(BuildContext context, ArticlesProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            provider.errorMessage ?? 'Unknown error',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              provider.retryGetArticles();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
