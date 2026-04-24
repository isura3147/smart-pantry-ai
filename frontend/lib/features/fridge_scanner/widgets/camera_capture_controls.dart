import 'package:flutter/material.dart';

class CameraCaptureControls extends StatelessWidget {
  final VoidCallback onFlashTap;
  final VoidCallback onCaptureTap;
  final VoidCallback onGalleryTap;

  const CameraCaptureControls({
    super.key,
    required this.onFlashTap,
    required this.onCaptureTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget sideButton(IconData icon, VoidCallback onTap) {
      return Material(
        // withOpacity keeps compatibility with older Flutter stable versions, used for best practice.
        color: cs.surfaceContainerLow.withOpacity(0.9),
        shape: const CircleBorder(),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          color: cs.onSurface,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        sideButton(Icons.flash_on_rounded, onFlashTap),
        GestureDetector(
          onTap: onCaptureTap,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cs.primary,
              border: Border.all(color: cs.primary, width: 4),
              boxShadow: [
                BoxShadow(
                  color: cs.primary.withOpacity(0.35),
                  blurRadius: 14,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.camera_alt_rounded, color: cs.onPrimary, size: 34),
          ),
        ),
        sideButton(Icons.photo_library_rounded, onGalleryTap),
      ],
    );
  }
}