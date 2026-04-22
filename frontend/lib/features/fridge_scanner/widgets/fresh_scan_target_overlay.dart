import 'package:flutter/material.dart';

class FreshScanTargetOverlay extends StatelessWidget {
  const FreshScanTargetOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // CustomPaint is ideal here because the bracket is purely decorative and
    // should not participate in layout. It paints over the full camera area.
    return CustomPaint(
      painter: _BracketPainter(Theme.of(context).colorScheme.primary),
      child: const SizedBox.expand(),
    );
  }
}

class _BracketPainter extends CustomPainter {
  final Color color;
  _BracketPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const boxW = 230.0;
    const boxH = 230.0;
    const arm = 34.0;

    final left = (size.width - boxW) / 2;
    final top = (size.height - boxH) / 2 - 40;
    final right = left + boxW;
    final bottom = top + boxH;

    // Corner arms create a scanner-like targeting frame without obscuring
    // the center area where users aim items.
    canvas.drawLine(Offset(left, top + arm), Offset(left, top), paint);
    canvas.drawLine(Offset(left, top), Offset(left + arm, top), paint);

    canvas.drawLine(Offset(right - arm, top), Offset(right, top), paint);
    canvas.drawLine(Offset(right, top), Offset(right, top + arm), paint);

    canvas.drawLine(Offset(left, bottom - arm), Offset(left, bottom), paint);
    canvas.drawLine(Offset(left, bottom), Offset(left + arm, bottom), paint);

    canvas.drawLine(Offset(right - arm, bottom), Offset(right, bottom), paint);
    canvas.drawLine(Offset(right, bottom - arm), Offset(right, bottom), paint);
  }

  @override
  bool shouldRepaint(covariant _BracketPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}