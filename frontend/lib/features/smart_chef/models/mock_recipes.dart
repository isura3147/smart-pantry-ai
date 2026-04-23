import 'nutritional_info.dart';
import 'recipe.dart';
import 'recipe_ingredient.dart';

// replace with recipes from the generation endpoint.
class MockRecipes {
  MockRecipes._();

  static const Recipe spicyCoconutPapayaCurry = Recipe(
    id: 'spicy-coconut-papaya',
    title: 'Spicy Coconut & Papaya Curry',
    heroImageUrl:
        'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800',
    prepMinutes: 20,
    calories: 340,
    matchPercent: 94,
    description:
        'Light, tangy, and good for hot afternoons when nothing '
        'heavy sounds appealing.',
    fromFridge: [
      RecipeIngredient(name: 'Papaya', quantity: 1, unit: 'Large'),
      RecipeIngredient(name: 'Coconut Milk', quantity: 400, unit: 'ml'),
    ],
    assumedStaples: [
      RecipeIngredient(name: 'Honey', quantity: 2, unit: 'tbsp'),
      RecipeIngredient(name: 'Lime Juice', quantity: 1, unit: 'tbsp'),
      RecipeIngredient(name: 'Salt', quantity: 0.5, unit: 'tsp'),
    ],
    instructions: [
      'Dice the papaya into bite-sized pieces, ensuring even cubes for '
          'consistent cooking texture.',
      'Simmer coconut milk with curry powder in a heavy-bottomed pan over '
          'medium heat until fragrant and slightly reduced.',
      'Add papaya and cook for 10 minutes, allowing the fruit to absorb the '
          'spicy coconut infusion without becoming too soft.',
      'Serve hot with fresh cilantro and a lime wedge to brighten the rich '
          'coconut flavors.',
    ],
    nutrition: NutritionalInfo(
      calories: 342,
      proteinGrams: 12,
      carbsGrams: 28,
      fatGrams: 18,
    ),
  );

  static const Recipe tropicalMorningBowl = Recipe(
    id: 'tropical-morning-bowl',
    title: 'Tropical Morning Bowl',
    heroImageUrl:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
    prepMinutes: 10,
    calories: 210,
    matchPercent: 82,
    description:
        'Quick breakfast bowl. Soak the oats the night before if '
        'you want it ready even faster in the morning.',
    fromFridge: [
      RecipeIngredient(name: 'Papaya', quantity: 0.5, unit: 'Large'),
      RecipeIngredient(name: 'Coconut Milk', quantity: 100, unit: 'ml'),
    ],
    assumedStaples: [
      RecipeIngredient(name: 'Rolled Oats', quantity: 0.5, unit: 'cup'),
      RecipeIngredient(name: 'Chia Seeds', quantity: 1, unit: 'tbsp'),
      RecipeIngredient(name: 'Honey', quantity: 1, unit: 'tsp'),
    ],
    instructions: [
      'Soak rolled oats and chia seeds in coconut milk for 5 minutes until '
          'softened.',
      'Slice papaya into thin wedges and layer over the oats.',
      'Drizzle with honey and garnish with a pinch of toasted coconut flakes.',
    ],
    nutrition: NutritionalInfo(
      calories: 212,
      proteinGrams: 7,
      carbsGrams: 32,
      fatGrams: 8,
    ),
  );

  static const Recipe creamyCoconutCooler = Recipe(
    id: 'coconut-cooler',
    title: 'Creamy Coconut Cooler',
    heroImageUrl:
        'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800',
    prepMinutes: 5,
    calories: 180,
    matchPercent: 67,
    description: 'Basically a smoothie. Blend everything, pour, done.',
    fromFridge: [
      RecipeIngredient(name: 'Papaya', quantity: 0.5, unit: 'Large'),
      RecipeIngredient(name: 'Coconut Milk', quantity: 200, unit: 'ml'),
    ],
    assumedStaples: [
      RecipeIngredient(name: 'Ice Cubes', quantity: 5, unit: 'pcs'),
      RecipeIngredient(name: 'Lime Juice', quantity: 1, unit: 'tsp'),
      RecipeIngredient(name: 'Honey', quantity: 1, unit: 'tbsp'),
    ],
    instructions: [
      'Add papaya, coconut milk, lime juice, honey and ice to a blender.',
      'Blend on high for 45 seconds until smooth and frothy.',
      'Pour into a tall glass and serve immediately with a lime wedge.',
    ],
    nutrition: NutritionalInfo(
      calories: 180,
      proteinGrams: 3,
      carbsGrams: 26,
      fatGrams: 9,
    ),
  );

  static const List<Recipe> all = [
    spicyCoconutPapayaCurry,
    tropicalMorningBowl,
    creamyCoconutCooler,
  ];
}
