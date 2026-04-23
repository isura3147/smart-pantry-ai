import 'nutritional_info.dart';
import 'recipe_ingredient.dart';

class Recipe {
  final String id;
  final String title;
  final String heroImageUrl;
  final int prepMinutes;
  final int calories;
  final int matchPercent;
  final String description;
  final List<RecipeIngredient> fromFridge;
  final List<RecipeIngredient> assumedStaples;
  final List<String> instructions;
  final NutritionalInfo nutrition;

  const Recipe({
    required this.id,
    required this.title,
    required this.heroImageUrl,
    required this.prepMinutes,
    required this.calories,
    required this.matchPercent,
    required this.description,
    required this.fromFridge,
    required this.assumedStaples,
    required this.instructions,
    required this.nutrition,
  });
}
