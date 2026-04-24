import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? trailingLabel;

  const SectionHeader({super.key, required this.title, this.trailingLabel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        if (trailingLabel != null)
          Text(
            trailingLabel!,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.08,
            ),
          ),
      ],
    );
  }
}
