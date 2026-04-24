import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// A single grocery item extracted from a receipt.
class ScannedItem {
  const ScannedItem({
    required this.name,
    required this.quantity,
    this.price,
    required this.icon,
  });

  final String name;
  final String quantity;
  final double? price;
  final IconData icon;
}


class OcrService {
  /// ⚠️ Change this to your Python backend PC's local-network IP + port.

  static const String baseUrl = 'http://192.168.1.1:5000';

  static Future<List<ScannedItem>> scanReceipt(File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/ocr/scan-receipt'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      final streamed =
          await request.send().timeout(const Duration(seconds: 30));
      final body = await streamed.stream.bytesToString();

      if (streamed.statusCode == 200) {
        final data = jsonDecode(body) as Map<String, dynamic>;
        final List<dynamic> raw = data['items'] ?? [];
        return raw.map((e) {
          final name = (e['name'] as String?) ?? 'Unknown Item';
          final qty = (e['quantity'] as String?) ?? '1';
          final price = (e['price'] as num?)?.toDouble();
          return ScannedItem(
            name: name,
            quantity:
                price != null ? '\$${price.toStringAsFixed(2)}' : qty.toUpperCase(),
            price: price,
            icon: _iconFor(name),
          );
        }).toList();
      } else {
        throw Exception('HTTP ${streamed.statusCode}');
      }
    } catch (_) {
      
      return _mockItems();
    }
  }

  // ── Icon mapping ──────────────────────────────────────────────────────────
  static IconData _iconFor(String name) {
    final n = name.toLowerCase();
    if (_any(n, ['milk', 'cream', 'dairy', 'latte']))
      return Icons.water_drop_outlined;
    if (_any(n, ['egg'])) return Icons.egg_outlined;
    if (_any(n, [
      'bread', 'wheat', 'loaf', 'croissant', 'sourdough',
      'baguette', 'roll', 'horn', 'musu'
    ])) return Icons.breakfast_dining_outlined;
    if (_any(n, ['tomato', 'lettuce', 'spinach', 'salad', 'carrot',
      'broccoli', 'onion', 'garlic', 'vegetable', 'veg']))
      return Icons.eco_outlined;
    if (_any(n, ['apple', 'banana', 'orange', 'grape', 'berry',
      'strawberry', 'fruit', 'mango']))
      return Icons.apple;
    if (_any(n, ['chicken', 'beef', 'pork', 'meat', 'spam', 'ham',
      'sausage', 'turkey']))
      return Icons.kebab_dining_outlined;
    if (_any(n, ['juice', 'drink', 'water', 'boss', 'soda', 'tea',
      'coffee', 'premium', 'black']))
      return Icons.local_drink_outlined;
    if (_any(n, ['rice', 'onigiri', 'bento', 'pasta', 'noodle']))
      return Icons.rice_bowl_outlined;
    if (_any(n, ['cheese', 'butter', 'yogurt', 'curd']))
      return Icons.icecream_outlined;
    if (_any(n, ['fish', 'seafood', 'shrimp', 'tuna', 'salmon']))
      return Icons.set_meal_outlined;
    if (_any(n, ['chip', 'cookie', 'choco', 'candy', 'snack']))
      return Icons.cookie_outlined;
    return Icons.shopping_basket_outlined;
  }

  static bool _any(String text, List<String> kw) =>
      kw.any((k) => text.contains(k));

  // ── Mock fallback (used when backend is not yet running) ─────────────────
  static List<ScannedItem> _mockItems() => const [
        ScannedItem(
          name: 'Choco Horn',
          quantity: '\$2.50',
          price: 2.50,
          icon: Icons.cookie_outlined,
        ),
        ScannedItem(
          name: 'Organic Eggs 12P',
          quantity: '\$4.99',
          price: 4.99,
          icon: Icons.egg_outlined,
        ),
        ScannedItem(
          name: 'Strawberry Croissant',
          quantity: '\$4.20',
          price: 4.20,
          icon: Icons.breakfast_dining_outlined,
        ),
        ScannedItem(
          name: 'Whole Wheat Half',
          quantity: '\$4.00',
          price: 4.00,
          icon: Icons.breakfast_dining_outlined,
        ),
        ScannedItem(
          name: 'Premium Boss Black',
          quantity: '\$2.79',
          price: 2.79,
          icon: Icons.local_drink_outlined,
        ),
        ScannedItem(
          name: 'Onigiri Bento',
          quantity: '\$6.49',
          price: 6.49,
          icon: Icons.rice_bowl_outlined,
        ),
        ScannedItem(
          name: 'Spam Musubi',
          quantity: '\$2.69',
          price: 2.69,
          icon: Icons.kebab_dining_outlined,
        ),
      ];
}
