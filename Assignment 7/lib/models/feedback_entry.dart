/// One completed registration + feedback response.
///
/// The object is immutable: the form builds it once, hands it to the detail
/// screen as a route argument, and nothing downstream can mutate it.
class FeedbackEntry {
  const FeedbackEntry({
    required this.fullName,
    required this.email,
    required this.password,
    required this.track,
    required this.rating,
    required this.comments,
    required this.submittedAt,
  });

  final String fullName;
  final String email;
  final String password;
  final String track;
  final int rating;
  final String comments;
  final DateTime submittedAt;

  /// Never show a password back in plain text, even to its owner.
  String get maskedPassword => '*' * password.length;

  String get initials {
    final List<String> parts =
        fullName.trim().split(RegExp(r'\s+')).where((String p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.firstLetter();
    return parts.first.firstLetter() + parts.last.firstLetter();
  }

  String get ratingLabel {
    switch (rating) {
      case 5:
        return 'Loved it';
      case 4:
        return 'Really good';
      case 3:
        return 'Fine';
      case 2:
        return 'Missed the mark';
      default:
        return 'Not for me';
    }
  }

  FeedbackEntry copyWith({
    String? fullName,
    String? email,
    String? password,
    String? track,
    int? rating,
    String? comments,
    DateTime? submittedAt,
  }) {
    return FeedbackEntry(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      track: track ?? this.track,
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'fullName': fullName,
        'email': email,
        'track': track,
        'rating': rating,
        'comments': comments,
        'submittedAt': submittedAt.toIso8601String(),
      };
}

extension on String {
  String firstLetter() => isEmpty ? '' : substring(0, 1).toUpperCase();
}
