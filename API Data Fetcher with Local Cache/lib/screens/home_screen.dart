import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';
import '../widgets/skeleton_loader.dart';
import '../widgets/status_banner.dart';
import 'post_detail_screen.dart';

/// Result wrapper returned by [_loadData]. Bundling the posts together
/// with a `fromCache` flag and a `timestamp` lets a single FutureBuilder
/// know not just *what* to show, but *how* to label it (live vs cached).
class _LoadResult {
  final List<Post> posts;
  final bool fromCache;
  final DateTime? timestamp;

  _LoadResult({required this.posts, required this.fromCache, this.timestamp});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final CacheService _cacheService = CacheService();

  late Future<_LoadResult> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  /// Core logic for the assignment:
  /// 1. Try to fetch fresh data from the network.
  /// 2. On success, cache it with SharedPreferences and return it,
  ///    flagged as "live".
  /// 3. On failure (no internet, timeout, server error...), fall back
  ///    to whatever is in the local cache and flag it as "cached".
  /// 4. If there is no cache either, let the error propagate so the
  ///    FutureBuilder can show a proper error state.
  Future<_LoadResult> _loadData({bool forceNetwork = false}) async {
    try {
      final posts = await _apiService.fetchPosts(limit: 20);
      await _cacheService.savePosts(posts);
      return _LoadResult(
        posts: posts,
        fromCache: false,
        timestamp: DateTime.now(),
      );
    } on ApiException {
      final cached = await _cacheService.readCachedPosts();
      if (cached.isNotEmpty) {
        final ts = await _cacheService.readCacheTimestamp();
        return _LoadResult(posts: cached, fromCache: true, timestamp: ts);
      }
      // No network AND no cache — nothing we can show.
      rethrow;
    }
  }

  Future<void> _refresh() async {
    final result = _loadData();
    setState(() => _future = result);
    await result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _refresh,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<_LoadResult>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SkeletonLoader();
          }

          if (snapshot.hasError) {
            return _ErrorState(onRetry: _refresh);
          }

          final result = snapshot.data!;
          if (result.posts.isEmpty) {
            return _EmptyState(onRetry: _refresh);
          }

          return RefreshIndicator(
            color: AppTheme.primary,
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 4, bottom: 24),
              children: [
                StatusBanner(
                  isFromCache: result.fromCache,
                  timestamp: result.timestamp,
                ),
                ...result.posts.map(
                  (post) => Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                    child: PostCard(
                      post: post,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PostDetailScreen(post: post),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                color: AppTheme.error,
                size: 32,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Couldn\'t load your feed',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'No internet connection and no cached data was found on this device yet.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onRetry;
  const _EmptyState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_rounded, color: AppTheme.textSecondary, size: 40),
            const SizedBox(height: 14),
            Text('Nothing to show yet', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Reload'),
            ),
          ],
        ),
      ),
    );
  }
}
