import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text(
          'Settings Coming Soon',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
