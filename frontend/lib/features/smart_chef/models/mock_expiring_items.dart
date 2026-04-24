import 'food_item.dart';

// TODO: swap for real inventory data once that feature is in.
class MockExpiringItems {
  MockExpiringItems._();

  static final DateTime _now = DateTime.now();

  static final FoodItem papaya = FoodItem(
    name: 'Papaya',
    quantity: 1,
    unit: 'Large',
    expiresAt: _now,
  );

  static final FoodItem coconutMilk = FoodItem(
    name: 'Coconut',
    quantity: 400,
    unit: 'ml',
    expiresAt: _now.add(const Duration(days: 2)),
  );

  static final FoodItem spinach = FoodItem(
    name: 'Spinach',
    quantity: 1,
    unit: 'bunch',
    expiresAt: _now.add(const Duration(days: 3)),
  );

  static final FoodItem greekYogurt = FoodItem(
    name: 'Greek Yogurt',
    quantity: 500,
    unit: 'g',
    expiresAt: _now.add(const Duration(days: 4)),
  );

  static final List<FoodItem> all = [papaya, coconutMilk, spinach, greekYogurt];
}
