import 'package:flutter/material.dart';

class InventoryDashboardScreen extends StatelessWidget {
  const InventoryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Inventory Dashboard'),
      ),
      body: const Center(
        child: Text(
          'Inventory Dashboard Coming Soon',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
