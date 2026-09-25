/// Simple, immutable data model that represents a single post
/// returned by the JSONPlaceholder REST API:
/// https://jsonplaceholder.typicode.com/posts
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  /// Builds a [Post] from a decoded JSON map (used both for the live
  /// API response and for data read back out of the local cache).
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: (json['title'] as String).trim(),
      body: (json['body'] as String).trim(),
    );
  }

  /// Converts the model back to a JSON-friendly map so the whole
  /// list can be encoded to a String and stored with SharedPreferences.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
