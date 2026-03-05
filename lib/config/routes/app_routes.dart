import 'package:flightnews/feature/articles/presentation/pages/articles_page.dart';
import 'package:flightnews/feature/articles/presentation/pages/articles_webview_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Go Router configuration untuk aplikasi
final appRouter = GoRouter(
  routes: [
    // Home route - Articles list page
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const ArticlesPage(),
    ),

    // Article WebView route
    GoRoute(
      path: '/article/view',
      name: 'article_view',
      builder: (context, state) {
        // Get extra data (url & title) dari navigation
        final extra = state.extra as Map<String, dynamic>?;

        if (extra == null || extra['url'] == null || extra['title'] == null) {
          // Jika data tidak lengkap, kembali ke home
          return const ArticlesPage();
        }

        return ArticleWebViewPage(
          url: extra['url'] as String,
          title: extra['title'] as String,
        );
      },
    ),
  ],

  // Error page untuk route yang tidak ditemukan
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page not found'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  },
);
