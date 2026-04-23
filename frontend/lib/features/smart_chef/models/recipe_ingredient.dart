class RecipeIngredient {
  final String name;
  final double quantity;
  final String unit;

  const RecipeIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  String get displayAmount {
    final asInt = quantity.toInt();
    final isWhole = quantity == asInt.toDouble();
    final amount = isWhole ? asInt.toString() : quantity.toString();
    return '$amount $unit'.trim();
  }
}
