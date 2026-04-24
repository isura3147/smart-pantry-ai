import 'package:flutter/material.dart';
import 'detected_item.dart';

class DetectedItemCard extends StatelessWidget {
  final DetectedItem item;
  final ValueChanged<bool> onChanged;

  const DetectedItemCard({
    super.key,
    required this.item,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onChanged(!item.isSelected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A).withOpacity(0.8), // Glassy card base
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            // Mock leading icon matching Figma
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.eco_outlined, color: cs.onSurfaceVariant, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: t.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.freshness.toUpperCase()} • ${item.units} UNITS',
                    style: t.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.5,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            // Figma-style rounded checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: item.isSelected ? cs.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: item.isSelected ? cs.primary : cs.outline,
                  width: 1.5,
                ),
              ),
              child: item.isSelected
                  ? Icon(Icons.check, size: 16, color: cs.onPrimary)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}