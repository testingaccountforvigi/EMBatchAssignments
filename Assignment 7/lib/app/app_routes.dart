import 'package:flutter/material.dart';

import '../models/feedback_entry.dart';
import '../screens/detail_screen.dart';
import '../screens/form_screen.dart';
import '../screens/home_screen.dart';

/// Every route name in the app lives here as a constant, so a typo becomes a
/// compile-time error instead of a blank screen at runtime.
class AppRoutes {
  const AppRoutes._();

  static const String home = '/';
  static const String form = '/form';
  static const String detail = '/detail';

  /// Screens that take no arguments can use the plain route table.
  static final Map<String, WidgetBuilder> staticRoutes = <String, WidgetBuilder>{
    home: (_) => const HomeScreen(),
    form: (_) => const FormScreen(),
  };

  /// Screens that need data use [onGenerateRoute] so the arguments can be
  /// type-checked in one place rather than cast inside the screen.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detail:
        final Object? args = settings.arguments;
        if (args is FeedbackEntry) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => DetailScreen(entry: args),
          );
        }
        return _errorRoute(
          settings,
          'The summary screen needs a completed response to display.',
        );
      default:
        // Returning null lets `routes` and then `onUnknownRoute` take over.
        return null;
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return _errorRoute(settings, 'No screen is registered for this address.');
  }

  static Route<dynamic> _errorRoute(RouteSettings settings, String message) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        final ThemeData theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Route not found')),
          body: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  settings.name ?? 'unnamed route',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(message, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(home, (Route<dynamic> r) => false),
                  child: const Text('Back to start'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
