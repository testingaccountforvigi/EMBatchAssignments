import 'package:flutter/material.dart';

import 'dashboard.dart';

void main() {
  runApp(const ProductIntelligenceApp());
}

class ProductIntelligenceApp extends StatelessWidget {
  const ProductIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Intelligence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const DashboardScreen(),
    );
  }
}
