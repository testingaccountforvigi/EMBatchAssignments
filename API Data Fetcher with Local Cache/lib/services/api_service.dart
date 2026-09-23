import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/post.dart';

/// Thrown whenever the API call fails for any reason (no internet,
/// timeout, bad status code, malformed JSON, etc). Kept as a single
/// custom exception type so the UI layer can catch one thing and
/// show a friendly message.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

/// Thin wrapper around the JSONPlaceholder REST API.
///
/// JSONPlaceholder (https://jsonplaceholder.typicode.com) is a free
/// fake REST API commonly used for prototyping and learning — exactly
/// what this assignment calls for.
class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Fetches the first [limit] posts from the `/posts` endpoint.
  ///
  /// Throws an [ApiException] with a human readable message on any
  /// failure so the calling widget can decide whether to fall back
  /// to the local cache.
  Future<List<Post>> fetchPosts({int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl/posts?_limit=$limit');

    try {
      final response = await http.get(uri).timeout(
            const Duration(seconds: 12),
          );

      if (response.statusCode != 200) {
        throw ApiException(
          'Server responded with status ${response.statusCode}',
        );
      }

      final List<dynamic> decoded = jsonDecode(response.body) as List<dynamic>;
      return decoded
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw ApiException('No internet connection');
    } on HttpException {
      throw ApiException('Could not reach the server');
    } on FormatException {
      throw ApiException('Received malformed data from the server');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Something went wrong: $e');
    }
  }
}
