import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/post.dart';

/// Handles reading and writing the "last successful API result" to
/// local, persistent storage using SharedPreferences.
///
/// SharedPreferences is a simple key-value store backed by native
/// platform storage (NSUserDefaults on iOS, SharedPreferences on
/// Android). It is perfect for caching a small-to-medium JSON
/// payload like a list of posts, which is exactly what this
/// assignment asks for.
class CacheService {
  static const String _postsKey = 'cached_posts';
  static const String _timestampKey = 'cached_posts_timestamp';

  /// Persists [posts] as a JSON-encoded string, together with the
  /// current time so the UI can later show "last updated X ago".
  Future<void> savePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = posts.map((p) => p.toJson()).toList();
    await prefs.setString(_postsKey, jsonEncode(jsonList));
    await prefs.setString(_timestampKey, DateTime.now().toIso8601String());
  }

  /// Returns the cached posts, or an empty list if nothing has been
  /// cached yet (e.g. first ever launch with no connectivity).
  Future<List<Post>> readCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_postsKey);
    if (raw == null || raw.isEmpty) return [];

    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Returns the [DateTime] the cache was last written, or null if
  /// there is no cache yet.
  Future<DateTime?> readCacheTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_timestampKey);
    if (raw == null) return null;
    return DateTime.tryParse(raw);
  }

  /// True when at least one successful fetch has ever been cached.
  Future<bool> hasCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_postsKey);
  }

  /// Wipes the cache. Exposed for a "clear cache" debug action and
  /// for testing the empty/first-launch state.
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_postsKey);
    await prefs.remove(_timestampKey);
  }
}
