import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/smart_chef/screens/ai_chef_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Pantry',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const AIChefDashboardScreen(),
    );
  }
}
