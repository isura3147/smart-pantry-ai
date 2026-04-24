import 'package:flutter/material.dart';


class ScanFrameOverlay extends StatefulWidget {
  const ScanFrameOverlay({super.key});

  @override
  State<ScanFrameOverlay> createState() => _ScanFrameOverlayState();
}

class _ScanFrameOverlayState extends State<ScanFrameOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scanLine;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLine = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

      
        const hPad = 40.0;
        const vPad = 80.0;
        final frameLeft = hPad;
        final frameTop = vPad;
        final frameRight = w - hPad;
        final frameBottom = h - vPad;

        return AnimatedBuilder(
          animation: _scanLine,
          builder: (context, _) {
            final scanY =
                frameTop + (frameBottom - frameTop) * _scanLine.value;
            return CustomPaint(
              painter: _ScanOverlayPainter(
                frameLeft: frameLeft,
                frameTop: frameTop,
                frameRight: frameRight,
                frameBottom: frameBottom,
                scanY: scanY,
              ),
            );
          },
        );
      },
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  const _ScanOverlayPainter({
    required this.frameLeft,
    required this.frameTop,
    required this.frameRight,
    required this.frameBottom,
    required this.scanY,
  });

  final double frameLeft;
  final double frameTop;
  final double frameRight;
  final double frameBottom;
  final double scanY;

  static const Color _neon = Color(0xFF00FF7F);
  static const double _cornerLen = 28.0;
  static const double _strokeW = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    
    final dimPaint = Paint()..color = Colors.black.withOpacity(0.45);
    final outerRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final innerRect = Rect.fromLTRB(frameLeft, frameTop, frameRight, frameBottom);
    final path = Path.combine(
      PathOperation.difference,
      Path()..addRect(outerRect),
      Path()..addRect(innerRect),
    );
    canvas.drawPath(path, dimPaint);

   
    final cornerPaint = Paint()
      ..color = _neon
      ..strokeWidth = _strokeW
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // top-left
    canvas.drawLine(
        Offset(frameLeft, frameTop + _cornerLen), Offset(frameLeft, frameTop), cornerPaint);
    canvas.drawLine(
        Offset(frameLeft, frameTop), Offset(frameLeft + _cornerLen, frameTop), cornerPaint);

    // top-right
    canvas.drawLine(
        Offset(frameRight - _cornerLen, frameTop), Offset(frameRight, frameTop), cornerPaint);
    canvas.drawLine(
        Offset(frameRight, frameTop), Offset(frameRight, frameTop + _cornerLen), cornerPaint);

    // bottom-left
    canvas.drawLine(
        Offset(frameLeft, frameBottom - _cornerLen), Offset(frameLeft, frameBottom), cornerPaint);
    canvas.drawLine(
        Offset(frameLeft, frameBottom), Offset(frameLeft + _cornerLen, frameBottom), cornerPaint);

    // bottom-right
    canvas.drawLine(
        Offset(frameRight - _cornerLen, frameBottom), Offset(frameRight, frameBottom), cornerPaint);
    canvas.drawLine(
        Offset(frameRight, frameBottom), Offset(frameRight, frameBottom - _cornerLen), cornerPaint);

    // ── scan line ──────────────────────────────────────────────────────────
    final scanPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          _neon.withOpacity(0.0),
          _neon.withOpacity(0.7),
          _neon.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTRB(frameLeft, scanY - 1, frameRight, scanY + 1))
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(frameLeft + 8, scanY),
      Offset(frameRight - 8, scanY),
      scanPaint,
    );
  }

  @override
  bool shouldRepaint(_ScanOverlayPainter old) =>
      old.scanY != scanY ||
      old.frameLeft != frameLeft ||
      old.frameTop != frameTop;
}
