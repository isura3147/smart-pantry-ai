import 'package:flutter/material.dart';

import '../models/recipe_ingredient.dart';

class StapleRow extends StatelessWidget {
  final RecipeIngredient staple;

  const StapleRow({super.key, required this.staple});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(staple.name, style: theme.textTheme.bodyMedium)),
          Text(
            staple.displayAmount,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
