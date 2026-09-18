import 'package:flutter/material.dart';

import 'app/app_routes.dart';
import 'app/app_theme.dart';

void main() {
  runApp(const EncoreApp());
}

/// Root widget.
///
/// Navigation is fully name-driven:
///   * [MaterialApp.routes]          -> simple screens with no arguments
///   * [MaterialApp.onGenerateRoute] -> screens that need typed arguments
///   * [MaterialApp.onUnknownRoute]  -> fallback for a mistyped route name
class EncoreApp extends StatelessWidget {
  const EncoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.staticRoutes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
