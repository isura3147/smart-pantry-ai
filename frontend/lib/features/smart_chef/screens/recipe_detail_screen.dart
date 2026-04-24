import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/chef_app_bar.dart';
import '../widgets/ingredient_check_tile.dart';
import '../widgets/instruction_step_tile.dart';
import '../widgets/nutritional_analysis_card.dart';
import '../widgets/section_header.dart';
import '../widgets/staple_row.dart';

// TODO: save / share / favourite — waiting on backend endpoints.
// ingredient tiles are hardcoded to checked, needs real pantry match.
class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const ChefAppBar(
        title: 'Recipe Generator',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroImage(url: recipe.heroImageUrl),
            const SizedBox(height: 22),
            Text(
              recipe.title,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 28,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 14),
            _MetaBadgesRow(
              prepMinutes: recipe.prepMinutes,
              calories: recipe.calories,
            ),
            const SizedBox(height: 32),
            SectionHeader(
              title: 'From Your Fridge',
              trailingLabel: '${recipe.fromFridge.length} items',
            ),
            const SizedBox(height: 14),
            for (int i = 0; i < recipe.fromFridge.length; i++) ...[
              IngredientCheckTile(ingredient: recipe.fromFridge[i]),
              if (i < recipe.fromFridge.length - 1) const SizedBox(height: 10),
            ],
            const SizedBox(height: 32),
            const SectionHeader(title: 'Assumed Staples'),
            const SizedBox(height: 8),
            for (final staple in recipe.assumedStaples)
              StapleRow(staple: staple),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Instructions'),
            const SizedBox(height: 8),
            for (int i = 0; i < recipe.instructions.length; i++)
              InstructionStepTile(
                number: i + 1,
                text: recipe.instructions[i],
              ),
            const SizedBox(height: 32),
            NutritionalAnalysisCard(
              nutrition: recipe.nutrition,
              description: recipe.description,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String url;
  const _HeroImage({required this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              color: theme.colorScheme.surface,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
                strokeWidth: 2,
              ),
            );
          },
          errorBuilder: (context, error, stack) => Container(
            color: theme.colorScheme.surface,
            alignment: Alignment.center,
            child: Icon(
              Icons.restaurant_rounded,
              size: 56,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _MetaBadgesRow extends StatelessWidget {
  final int prepMinutes;
  final int calories;

  const _MetaBadgesRow({
    required this.prepMinutes,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 20,
      runSpacing: 8,
      children: [
        _MetaBadge(
          icon: Icons.access_time_rounded,
          label: 'PREP TIME: $prepMinutes MINS',
          color: theme.colorScheme.primary,
        ),
        _MetaBadge(
          icon: Icons.local_fire_department_outlined,
          label: '$calories KCAL',
          color: theme.colorScheme.primary,
        ),
      ],
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0.08,
          ),
        ),
      ],
    );
  }
}
