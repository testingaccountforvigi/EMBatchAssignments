import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price; // in INR
  final IconData icon;
  final Color themeColor;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.icon,
    required this.themeColor,
  });
}

// In-memory sample dataset
final List<Product> sampleProducts = [
  const Product(
    id: '1',
    name: 'Wireless Headphones',
    category: 'Electronics',
    price: 2999.00,
    icon: Icons.headphones_rounded,
    themeColor: Color(0xFF6C5CE7),
  ),
  const Product(
    id: '2',
    name: 'Running Shoes',
    category: 'Footwear',
    price: 4499.00,
    icon: Icons.directions_run_rounded,
    themeColor: Color(0xFFFF7675),
  ),
  const Product(
    id: '3',
    name: 'Mechanical Keyboard',
    category: 'Electronics',
    price: 9999.00,
    icon: Icons.keyboard_rounded,
    themeColor: Color(0xFF00CEC9),
  ),
  const Product(
    id: '4',
    name: 'Cotton T-Shirt',
    category: 'Apparel',
    price: 1299.00,
    icon: Icons.checkroom_rounded,
    themeColor: Color(0xFF74B9FF),
  ),
  const Product(
    id: '5',
    name: 'Smart Watch',
    category: 'Electronics',
    price: 15499.00,
    icon: Icons.watch_rounded,
    themeColor: Color(0xFFE17055),
  ),
  const Product(
    id: '6',
    name: 'Leather Jacket',
    category: 'Apparel',
    price: 18999.00,
    icon: Icons.dry_cleaning_rounded,
    themeColor: Color(0xFF2D3436),
  ),
  const Product(
    id: '7',
    name: 'Travel Backpack',
    category: 'Accessories',
    price: 3299.00,
    icon: Icons.backpack_rounded,
    themeColor: Color(0xFF00B894),
  ),
  const Product(
    id: '8',
    name: 'Ceramic Mug',
    category: 'Home',
    price: 450.00,
    icon: Icons.coffee_rounded,
    themeColor: Color(0xFFE84393),
  ),
];
