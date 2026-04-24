import 'package:flutter/material.dart';

import '../models/nutritional_info.dart';
import 'nutrition_stat_card.dart';

class NutritionalAnalysisCard extends StatelessWidget {
  final NutritionalInfo nutrition;
  final String description;

  const NutritionalAnalysisCard({
    super.key,
    required this.nutrition,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nutritional Analysis',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: NutritionStatCard(
                  label: 'Calories',
                  value: '${nutrition.calories}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NutritionStatCard(
                  label: 'Protein',
                  value: '${nutrition.proteinGrams}g',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: NutritionStatCard(
                  label: 'Carbs',
                  value: '${nutrition.carbsGrams}g',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NutritionStatCard(
                  label: 'Fat',
                  value: '${nutrition.fatGrams}g',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
