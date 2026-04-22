class DetectedItem {
  final String name;
  final String freshness;
  final int units;
  final bool isSelected;

  const DetectedItem({
    required this.name,
    required this.freshness,
    required this.units,
    this.isSelected = true,
  });

  DetectedItem copyWith({
    String? name,
    String? freshness,
    int? units,
    bool? isSelected,
  }) {
    return DetectedItem(
      name: name ?? this.name,
      freshness: freshness ?? this.freshness,
      units: units ?? this.units,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}