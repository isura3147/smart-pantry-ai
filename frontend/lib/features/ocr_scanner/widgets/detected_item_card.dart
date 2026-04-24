import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetectedItemCard extends StatelessWidget {
  const DetectedItemCard({
    super.key,
    required this.name,
    required this.quantity,
    required this.icon,
    required this.isSelected,
    required this.onToggle,
  });

  final String name;
  final String quantity;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onToggle;

  static const Color _neon = Color(0xFF00FF7F);
  static const Color _surface = Color(0xFF1E1E1E);
  static const Color _surfaceHigher = Color(0xFF262626);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _neon.withOpacity(0.35) : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            // ── icon container ──────────────────────────────────────────
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _surfaceHigher,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: _neon, size: 24),
            ),
            const SizedBox(width: 14),

            // ── name + quantity badge ───────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: _surfaceHigher,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      quantity,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── checkbox ────────────────────────────────────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? _neon : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? _neon : const Color(0xFF444444),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.black, size: 18)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
