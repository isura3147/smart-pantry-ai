// TODO(inventory): once inventory ships their FoodItem, either delete this
//onlt if the fields match or keep it and map their model into it.s a view-model.
class FoodItem {
  final String name;
  final double quantity;
  final String unit;
  final DateTime expiresAt;

  const FoodItem({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.expiresAt,
  });

  int daysUntilExpiry({DateTime? from}) {
    final today = _dateOnly(from ?? DateTime.now());
    final target = _dateOnly(expiresAt);
    return target.difference(today).inDays;
  }

  String expiryLabel({DateTime? from}) {
    final days = daysUntilExpiry(from: from);
    if (days < 0) return 'EXPIRED';
    if (days == 0) return 'EXPIRES TODAY';
    if (days == 1) return '1 DAY LEFT';
    return '$days DAYS LEFT';
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
