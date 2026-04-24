import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/ocr_service.dart';
import '../widgets/detected_item_card.dart';


class DetectedItemsScreen extends StatefulWidget {
  const DetectedItemsScreen({super.key, required this.items});

 
  final List<ScannedItem> items;

  @override
  State<DetectedItemsScreen> createState() => _DetectedItemsScreenState();
}

class _DetectedItemsScreenState extends State<DetectedItemsScreen>
    with SingleTickerProviderStateMixin {
  static const Color _neon = Color(0xFF00FF7F);
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _sheet = Color(0xFF171717);

  late List<bool> _selected;

  late final AnimationController _sheetController;
  late final Animation<Offset> _sheetSlide;

  @override
  void initState() {
    super.initState();
   
    _selected = List.filled(widget.items.length, true);

    _sheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _sheetSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _sheetController, curve: Curves.easeOutCubic));

    _sheetController.forward();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  int get _selectedCount => _selected.where((v) => v).length;

  void _toggleItem(int index) {
    HapticFeedback.selectionClick();
    setState(() => _selected[index] = !_selected[index]);
  }

  void _confirmAndSave() {
    HapticFeedback.mediumImpact();
    final saved = [
      for (int i = 0; i < widget.items.length; i++)
        if (_selected[i]) widget.items[i].name,
    ];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _neon,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          '${saved.length} item${saved.length == 1 ? '' : 's'} saved to inventory!',
          style: GoogleFonts.plusJakartaSans(
              color: Colors.black, fontWeight: FontWeight.w700),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Stack(
                children: [
                  // Receipt / camera background
                  Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [
                          Color(0xFF3D2B1F),
                          Color(0xFF1A120C),
                          Color(0xFF0A0806),
                        ],
                      ),
                    ),
                  ),
                  // Slide-up results sheet
                  SlideTransition(
                    position: _sheetSlide,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildResultsSheet(),
                    ),
                  ),
                ],
              ),
            ),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: _bg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: _neon),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Text('FreshScan',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3)),
          const Spacer(),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF2A2A2A),
            child: Icon(Icons.person, color: Colors.white60, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSheet() {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.65),
      decoration: const BoxDecoration(
        color: _sheet,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 4),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),

          // Header row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Detected Items',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.3)),
                      const SizedBox(height: 4),
                      Text('Verify items before saving to inventory.',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white54)),
                    ],
                  ),
                ),
                // Found badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                      color: _neon,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('${widget.items.length} found',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Item list
          Flexible(
            child: widget.items.isEmpty
                ? _emptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (context, i) {
                      final item = widget.items[i];
                      return DetectedItemCard(
                        name: item.name,
                        quantity: item.quantity,
                        icon: item.icon,
                        isSelected: _selected[i],
                        onToggle: () => _toggleItem(i),
                      );
                    },
                  ),
          ),

          // Confirm & Save
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _selectedCount > 0 ? _confirmAndSave : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _neon,
                  foregroundColor: Colors.black,
                  disabledBackgroundColor: const Color(0xFF1E2E24),
                  disabledForegroundColor: Colors.white30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.check_circle_outline, size: 20),
                label: Text('Confirm & Save',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined,
                color: Color(0xFF444444), size: 48),
            const SizedBox(height: 12),
            Text('No items detected',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white38,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('Try scanning again with better lighting.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white24, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: _bg,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 6, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(icon: Icons.home_outlined, label: 'HOME', active: false),
          _navItem(
              icon: Icons.document_scanner_outlined,
              label: 'SCANNER',
              active: true),
          _navItem(
              icon: Icons.restaurant_menu_outlined,
              label: 'RECEIPES',
              active: false),
          _navItem(
              icon: Icons.settings_outlined,
              label: 'SETTINGS',
              active: false),
        ],
      ),
    );
  }

  Widget _navItem(
      {required IconData icon, required String label, required bool active}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? _neon : Colors.white38, size: 24),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: active ? _neon : Colors.white38)),
      ],
    );
  }
}
