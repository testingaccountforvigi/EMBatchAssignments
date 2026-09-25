import 'package:flutter_test/flutter_test.dart';
import 'package:encore_feedback/utils/validators.dart';

void main() {
  group('email', () {
    test('accepts a normal address', () {
      expect(Validators.email('riya.sharma@college.edu'), isNull);
    });
    test('rejects a missing domain dot', () {
      expect(Validators.email('riya@college'), isNotNull);
    });
    test('rejects an empty value', () {
      expect(Validators.email(''), isNotNull);
    });
  });

  group('password', () {
    test('needs eight characters', () {
      expect(Validators.password('ab1'), isNotNull);
    });
    test('needs a number', () {
      expect(Validators.password('onlyletters'), isNotNull);
    });
    test('accepts a valid password', () {
      expect(Validators.password('encore2026'), isNull);
    });
  });

  group('confirm password', () {
    test('flags a mismatch', () {
      expect(Validators.confirmPassword('encore2026', 'encore2025'), isNotNull);
    });
    test('passes on a match', () {
      expect(Validators.confirmPassword('encore2026', 'encore2026'), isNull);
    });
  });

  group('name', () {
    test('rejects digits', () {
      expect(Validators.name('Riya99'), isNotNull);
    });
    test('accepts a hyphenated name', () {
      expect(Validators.name('Riya Menon-Das'), isNull);
    });
  });
}
