import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ApiDataFetcherApp());
}

class ApiDataFetcherApp extends StatelessWidget {
  const ApiDataFetcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Data Fetcher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
