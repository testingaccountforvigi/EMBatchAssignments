/// Validation lives outside the widgets so the rules can be read, reused and
/// unit-tested without building any UI.
class Validators {
  const Validators._();

  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
  static final RegExp _hasLetter = RegExp(r'[A-Za-z]');
  static final RegExp _hasDigit = RegExp(r'\d');
  static final RegExp _nameChars = RegExp(r"^[A-Za-z][A-Za-z .'-]*$");

  static String? required(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your $field to continue.';
    }
    return null;
  }

  static String? name(String? value) {
    final String v = (value ?? '').trim();
    if (v.isEmpty) return 'Enter your name so we can credit the feedback.';
    if (v.length < 3) return 'That looks short - use at least 3 letters.';
    if (v.length > 40) return 'Keep the name under 40 characters.';
    if (!_nameChars.hasMatch(v)) return 'Letters, spaces and hyphens only.';
    return null;
  }

  static String? email(String? value) {
    final String v = (value ?? '').trim();
    if (v.isEmpty) return 'Enter the email you registered with.';
    if (v.contains(' ')) return 'An email address cannot contain spaces.';
    if (!_email.hasMatch(v)) return 'Check the format - it should look like you@site.com.';
    return null;
  }

  static String? password(String? value) {
    final String v = value ?? '';
    if (v.isEmpty) return 'Choose a password to secure your response.';
    if (v.length < 8) return 'Use at least 8 characters.';
    if (!_hasLetter.hasMatch(v)) return 'Add at least one letter.';
    if (!_hasDigit.hasMatch(v)) return 'Add at least one number.';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Repeat the password to confirm it.';
    if (value != original) return 'The two passwords do not match yet.';
    return null;
  }

  static String? track(String? value) {
    if (value == null || value.isEmpty) return 'Pick the session you attended.';
    return null;
  }

  static String? comments(String? value) {
    final String v = (value ?? '').trim();
    if (v.isNotEmpty && v.length < 5) return 'Either leave this blank or write a full thought.';
    if (v.length > 300) return 'Trim it to 300 characters.';
    return null;
  }

  /// Rough strength read-out used for the meter under the password field.
  static int strength(String value) {
    int score = 0;
    if (value.length >= 8) score++;
    if (value.length >= 12) score++;
    if (_hasDigit.hasMatch(value)) score++;
    if (RegExp(r'[A-Z]').hasMatch(value) && RegExp(r'[a-z]').hasMatch(value)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(value)) score++;
    return score.clamp(0, 5);
  }
}
