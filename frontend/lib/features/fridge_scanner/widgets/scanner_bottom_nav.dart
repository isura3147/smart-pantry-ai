import 'dart:ui';
import 'package:flutter/material.dart';

class ScannerBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ScannerBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget _buildNavItem(IconData icon, String label, int index, ColorScheme cs) {
    final isSelected = currentIndex == index;
    final color = isSelected ? cs.primary : cs.onSurfaceVariant;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 26,
              shadows: isSelected
                  ? [
                      BoxShadow(
                        color: cs.primary.withOpacity(0.8),
                        blurRadius: 12,
                      ),
                    ]
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 64 + bottomPadding,
          padding: EdgeInsets.only(bottom: bottomPadding),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A).withOpacity(0.65),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5),
            ),
          ),
          child: Row(
            children: [
              _buildNavItem(Icons.home_filled, 'Home', 0, cs),
              _buildNavItem(Icons.document_scanner_rounded, 'Scanner', 1, cs),
              _buildNavItem(Icons.restaurant_menu_rounded, 'Recipes', 2, cs),
              _buildNavItem(Icons.settings_rounded, 'Settings', 3, cs),
            ],
          ),
        ),
      ),
    );
  }
}
