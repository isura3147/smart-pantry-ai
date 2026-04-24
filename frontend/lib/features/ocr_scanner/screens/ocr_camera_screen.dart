import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/ocr_service.dart';
import '../widgets/scan_frame_overlay.dart';
import 'detected_items_screen.dart';

class OcrCameraScreen extends StatefulWidget {
  const OcrCameraScreen({super.key});

  @override
  State<OcrCameraScreen> createState() => _OcrCameraScreenState();
}

class _OcrCameraScreenState extends State<OcrCameraScreen>
    with SingleTickerProviderStateMixin {
  static const Color _neon = Color(0xFF00FF7F);
  static const Color _bg = Color(0xFF0A0A0A);

  CameraController? _cameraController;
  bool _cameraReady = false;
  String? _cameraError;
  bool _flashOn = false;
  bool _isScanning = false;

  late final AnimationController _captureController;
  late final Animation<double> _captureScale;

  @override
  void initState() {
    super.initState();
    _captureController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      value: 1.0,
    );
    _captureScale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _captureController, curve: Curves.easeOut),
    );
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _cameraError = 'No camera found on this device.');
        return;
      }
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _cameraController = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await _cameraController!.initialize();
      if (!mounted) return;
      setState(() => _cameraReady = true);
    } on CameraException catch (e) {
      setState(() => _cameraError = 'Camera error: ${e.description}');
    } catch (e) {
      setState(() => _cameraError = 'Failed to open camera: $e');
    }
  }

  @override
  void dispose() {
    _captureController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_cameraReady) return;
    HapticFeedback.lightImpact();
    final next = !_flashOn;
    try {
      await _cameraController!
          .setFlashMode(next ? FlashMode.torch : FlashMode.off);
    } catch (_) {}
    setState(() => _flashOn = next);
  }

  Future<void> _onCapture() async {
    if (_isScanning || !_cameraReady || _cameraController == null) return;
    HapticFeedback.mediumImpact();

    await _captureController.reverse();
    await _captureController.forward();

    setState(() => _isScanning = true);

    try {
      // ── Take real photo ─────────────────────────────────────────────────
      final XFile xFile = await _cameraController!.takePicture();
      final imageFile = File(xFile.path);

      // ── Call OCR service (Python backend) ────────────────────────────────
      final items = await OcrService.scanReceipt(imageFile);

      if (!mounted) return;
      setState(() => _isScanning = false);

      // ── Navigate to results ──────────────────────────────────────────────
      await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, anim, __) => DetectedItemsScreen(items: items),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
                CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isScanning = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scan failed: $e'),
          backgroundColor: Colors.red.shade800,
        ),
      );
    }
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
                fit: StackFit.expand,
                children: [
                  _buildCameraPreview(),
                  const ScanFrameOverlay(),
                  if (_isScanning) _buildScanningIndicator(),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 100,
                    child: _buildInstructionLabel(),
                  ),
                ],
              ),
            ),
            _buildControlBar(),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_cameraError != null) {
      return Container(
        color: _bg,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera_alt_outlined,
                  color: Color(0xFF444444), size: 64),
              const SizedBox(height: 16),
              Text(_cameraError!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white38, fontSize: 13)),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _initCamera,
                child: Text('Retry',
                    style: GoogleFonts.plusJakartaSans(color: _neon)),
              ),
            ],
          ),
        ),
      );
    }
    if (!_cameraReady || _cameraController == null) {
      return const Center(
          child: CircularProgressIndicator(color: Color(0xFF00FF7F)));
    }
    return CameraPreview(_cameraController!);
  }

  Widget _buildScanningIndicator() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _neon.withValues(alpha: 0.55)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: _neon),
            ),
            const SizedBox(width: 10),
            Text('Scanning receipt…',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionLabel() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text('Align receipt within the frame',
            style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
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

  Widget _buildControlBar() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _controlBtn(
            icon: _flashOn ? Icons.flash_on : Icons.flash_off,
            onTap: _toggleFlash,
            active: _flashOn,
          ),
          GestureDetector(
            onTap: _onCapture,
            child: ScaleTransition(
              scale: _captureScale,
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _neon,
                  boxShadow: [
                    BoxShadow(
                      color: _neon.withValues(alpha: 0.45),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _controlBtn(icon: Icons.photo_library_outlined, onTap: () {}),
        ],
      ),
    );
  }

  Widget _controlBtn(
      {required IconData icon,
      required VoidCallback onTap,
      bool active = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1A1A1A),
          border: Border.all(
            color: active ? _neon.withValues(alpha: 0.6) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child:
            Icon(icon, color: active ? _neon : Colors.white70, size: 22),
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
