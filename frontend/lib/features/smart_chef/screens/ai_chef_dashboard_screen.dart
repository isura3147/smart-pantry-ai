import 'package:flutter/material.dart';

import '../models/mock_expiring_items.dart';
import '../models/mock_recipes.dart';
import '../models/recipe.dart';
import '../widgets/category_chip.dart';
import '../widgets/chef_app_bar.dart';
import '../widgets/expiring_item_card.dart';
import '../widgets/generate_recipes_button.dart';
import '../widgets/recipe_suggestion_card.dart';
import 'recipe_detail_screen.dart';

class AIChefDashboardScreen extends StatefulWidget {
  const AIChefDashboardScreen({super.key});

  @override
  State<AIChefDashboardScreen> createState() => _AIChefDashboardScreenState();
}

class _AIChefDashboardScreenState extends State<AIChefDashboardScreen> {
  static const List<String> _categories = [
    'All Recipes',
    'Breakfast',
    'Lunch',
    'Dinner',
  ];

  int _selectedCategoryIndex = 0;

  void _openRecipe(Recipe recipe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: real inventory data
    final expiring = MockExpiringItems.all;
    // TODO(ai): read from the AI recipes provider once generation is wired up.
    final recipes = MockRecipes.all;

    return Scaffold(
      appBar: const ChefAppBar(title: 'AI Chef'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: _Greeting(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // TODO(ai): kick off recipe generation + show a loading state
              // once the AI service is connected.
              child: GenerateRecipesButton(onPressed: () {}),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: expiring.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => ExpiringItemCard(item: expiring[i]),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) => CategoryChip(
                  label: _categories[i],
                  isSelected: i == _selectedCategoryIndex,
                  onTap: () => setState(() => _selectedCategoryIndex = i),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Today's Suggestions",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  for (int i = 0; i < recipes.length; i++) ...[
                    RecipeSuggestionCard(
                      recipe: recipes[i],
                      onTap: () => _openRecipe(recipes[i]),
                    ),
                    if (i < recipes.length - 1) const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = theme.textTheme.displayLarge?.copyWith(
      fontSize: 30,
      height: 1.15,
    );
    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: "What's cooking,\n"),
          TextSpan(
            text: 'Chef?',
            style: TextStyle(color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
