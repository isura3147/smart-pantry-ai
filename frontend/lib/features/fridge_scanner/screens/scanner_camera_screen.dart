import 'package:flutter/material.dart';
import '../widgets/camera_capture_controls.dart';
import '../widgets/detected_item.dart';
import '../widgets/detected_items_bottom_sheet.dart';
import '../widgets/fresh_scan_target_overlay.dart';

class ScannerCameraScreen extends StatelessWidget {
  final String modeTitle;
  final bool showResults;
  final List<DetectedItem> items;
  final VoidCallback onBackTap;
  final VoidCallback onFlashTap;
  final VoidCallback onCaptureTap;
  final VoidCallback onGalleryTap;
  final void Function(int index, bool selected) onItemChanged;
  final VoidCallback onConfirm;
  final VoidCallback onDismissSheet;

  const ScannerCameraScreen({
    super.key,
    required this.modeTitle,
    required this.showResults,
    required this.items,
    required this.onBackTap,
    required this.onFlashTap,
    required this.onCaptureTap,
    required this.onGalleryTap,
    required this.onItemChanged,
    required this.onConfirm,
    required this.onDismissSheet,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cs.surfaceContainerHighest,
                    cs.surfaceContainerLowest,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  'Camera Preview (UI Mock)',
                  style: t.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
            ),
          ),
          const Positioned.fill(child: FreshScanTargetOverlay()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBackTap,
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: 8),
                  Text('FreshScan', style: t.titleLarge),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.person, size: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // Pushed up to 110px to clear the bottom nav bar completely
          Positioned(
            left: 0,
            right: 0,
            bottom: 110,
            child: CameraCaptureControls(
              onFlashTap: onFlashTap,
              onCaptureTap: onCaptureTap,
              onGalleryTap: onGalleryTap,
            ),
          ),
          // Sits exactly on top of the bottom nav instead of behind it
          if (showResults)
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: DetectedItemsBottomSheet(
                items: items,
                onItemChanged: onItemChanged,
                onConfirm: onConfirm,
                onDismiss: onDismissSheet,
              ),
            ),
        ],
      ),
    );
  }
}