import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login Screen after 2.5 seconds
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutral,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: AppTheme.neutral,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Title
                Hero(
                  tag: 'app_title',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'SmartPantry AI',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Hero(
                  tag: 'app_subtitle',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Your culinary inventory, intelligently curated.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom glow line
          Positioned(
            bottom: 8,
            left: 24,
            right: 24,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.neutral,
                    AppTheme.secondary.withValues(alpha: 0.5),
                    AppTheme.secondary.withValues(alpha: 0.5),
                    AppTheme.neutral,
                  ],
                  stops: const [0.0, 0.4, 0.6, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.secondary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
