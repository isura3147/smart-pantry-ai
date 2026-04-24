import 'package:flutter/material.dart';

class GenerateRecipesButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GenerateRecipesButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        icon: const Icon(Icons.auto_awesome_rounded, size: 20),
        label: const Text('Generate AI Recipes'),
      ),
    );
  }
}
