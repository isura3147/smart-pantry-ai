import 'package:flutter/material.dart';
import '../widgets/detected_item.dart';
import 'scanner_camera_screen.dart';
import 'scanner_mode_selection_screen.dart';

enum ScannerUiState { modeSelection, camera }

class FridgeScannerPage extends StatefulWidget {
  const FridgeScannerPage({super.key});

  @override
  State<FridgeScannerPage> createState() => _FridgeScannerPageState();
}

class _FridgeScannerPageState extends State<FridgeScannerPage> {
  int _navIndex = 1;
  ScannerUiState _scannerState = ScannerUiState.modeSelection;
  bool _showResults = false;
  String _activeMode = 'Fridge & Inventory Scan';

  List<DetectedItem> _items = const [
    DetectedItem(name: 'Apples', freshness: 'Fresh', units: 4),
    DetectedItem(name: 'Milk', freshness: 'Good', units: 1),
    DetectedItem(name: 'Carrots', freshness: 'Fresh', units: 6),
    DetectedItem(name: 'Spinach', freshness: 'Use Soon', units: 1),
  ];

  void _startCamera(String mode) {
    setState(() {
      _activeMode = mode;
      _scannerState = ScannerUiState.camera;
      _showResults = false;
    });
  }

  void _showDetectedItems() {
    setState(() => _showResults = true);
  }

  void _toggleDetectedItem(int index, bool selected) {
    setState(() {
      _items = List<DetectedItem>.from(_items)
        ..[index] = _items[index].copyWith(isSelected: selected);
    });
  }

  void _confirmAndSave() {
    final selectedCount = _items.where((e) => e.isSelected).length;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$selectedCount items confirmed and saved.')),
    );

    // Reset back to mode selection so repeated scans are one tap away.
    setState(() {
      _scannerState = ScannerUiState.modeSelection;
      _showResults = false;
    });
  }

  Widget _buildScannerFlow() {
    if (_scannerState == ScannerUiState.modeSelection) {
      return ScannerModeSelectionScreen(
        onFridgeScanTap: () => _startCamera('Fridge & Inventory Scan'),
        onReceiptScanTap: () => _startCamera('Receipt & Grocery Scan'),
        onUploadGalleryTap: () => _startCamera('Gallery Upload'),
      );
    }

    return ScannerCameraScreen(
      modeTitle: _activeMode,
      showResults: _showResults,
      items: _items,
      onBackTap: () {
        setState(() {
          _scannerState = ScannerUiState.modeSelection;
          _showResults = false;
        });
      },
      onFlashTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flash action hooked (UI-only stage).')),
        );
      },
      onCaptureTap: _showDetectedItems,
      onGalleryTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gallery action hooked (UI-only stage).')),
        );
      },
      onItemChanged: _toggleDetectedItem,
      onConfirm: _confirmAndSave,
      onDismissSheet: () {
        setState(() => _showResults = false);
      },
    );
  }

  Widget _buildTabPlaceholder(String title) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        '$title Screen',
        style: t.titleLarge?.copyWith(color: cs.onSurfaceVariant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_navIndex) {
      case 0:
        body = _buildTabPlaceholder('Home');
        break;
      case 1:
        body = _buildScannerFlow();
        break;
      case 2:
        body = _buildTabPlaceholder('Recipes');
        break;
      case 3:
        body = _buildTabPlaceholder('Settings');
        break;
      default:
        body = _buildScannerFlow();
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      body: body,
    );
  }
}