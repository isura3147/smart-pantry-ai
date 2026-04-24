import 'package:flutter/material.dart';
import '../widgets/scan_mode_card.dart';

class ScannerModeSelectionScreen extends StatelessWidget {
  final VoidCallback onFridgeScanTap;
  final VoidCallback onReceiptScanTap;
  final VoidCallback onUploadGalleryTap;

  const ScannerModeSelectionScreen({
    super.key,
    required this.onFridgeScanTap,
    required this.onReceiptScanTap,
    required this.onUploadGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        // Added 90px bottom padding so content doesn't hit the nav bar
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Identify Items', style: t.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(flex: 2), // Pushes cards toward the center
            ScanModeCard(
              icon: Icons.photo_camera_rounded,
              iconColor: cs.primary,
              title: 'Fridge & Inventory Scan',
              subtitle: 'Scan produce, dairy, and pantry items in one shot.',
              onTap: onFridgeScanTap,
            ),
            const SizedBox(height: 16),
            ScanModeCard(
              icon: Icons.receipt_long_rounded,
              iconColor: cs.primary,
              title: 'Receipt & Grocery Scan',
              subtitle: 'Extract purchased items from grocery receipts.',
              onTap: onReceiptScanTap,
            ),
            const Spacer(flex: 3), // Pushes button up slightly
            Center(
              child: Text(
                  'OR',
                  style: t.labelSmall?.copyWith(color: cs.onSurfaceVariant, letterSpacing: 1.5)
              ),
            ),
            const SizedBox(height: 16),
            // Green text/icon and pill-shaped border
            OutlinedButton.icon(
              onPressed: onUploadGalleryTap,
              icon: const Icon(Icons.photo_library_rounded),
              label: const Text('Upload from Gallery'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                side: BorderSide(color: cs.outline),
                foregroundColor: cs.primary, //  text & icon green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded pill shape
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}