// Renders the realistic glass jar body used by [AnimatedQuoteJar].
//
// This widget intentionally contains only the jar's visual structure.
// Animation concerns are handled by the jar feature's state layer.
// It uses a CustomPainter to achieve a 3D glass look with highlights.

import 'package:flutter/material.dart';
import 'jar_constants.dart';

class JarBody extends StatelessWidget {
  const JarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      size: Size(JarConstants.jarWidth, JarConstants.jarHeight),
      painter: _JarBodyPainter(),
    );
  }
}

class _JarBodyPainter extends CustomPainter {
  const _JarBodyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    // Jar path calculation
    final Path jarPath = _createJarPath(width, height);

    // 1. Draw drop shadow
    canvas.drawShadow(jarPath, JarConstants.dropShadowColor, 8.0, true);

    // 2. Base glass fill with subtle tint
    final Paint fillPaint = Paint()
      ..color = JarConstants.glassColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(jarPath, fillPaint);

    // 3. Inner shadow / edges for thickness
    final Paint borderPaint = Paint()
      ..color = JarConstants.glassShadow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawPath(jarPath, borderPaint);

    // 4. Highlight for realistic 3D cylinder feel
    final Path highlightPath = Path();
    highlightPath.moveTo(width * 0.15, JarConstants.jarNeckHeight + 20);
    highlightPath.quadraticBezierTo(
      width * 0.15,
      height * 0.5,
      width * 0.15,
      height - 30,
    );

    final Paint highlightPaint = Paint()
      ..color = JarConstants.glassHighlight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0); // Soft blur

    canvas.drawPath(highlightPath, highlightPaint);

    // Highlight on the neck
    final Path neckHighlightPath = Path();
    neckHighlightPath.moveTo(
      width / 2 - JarConstants.jarNeckWidth / 2 + 10,
      10,
    );
    neckHighlightPath.lineTo(
      width / 2 - JarConstants.jarNeckWidth / 2 + 10,
      JarConstants.jarNeckHeight - 10,
    );

    canvas.drawPath(neckHighlightPath, highlightPaint);
  }

  Path _createJarPath(double width, double height) {
    final Path path = Path();

    const double neckWidth = JarConstants.jarNeckWidth;
    const double neckHeight = JarConstants.jarNeckHeight;
    const double radius = JarConstants.jarCornerRadius;

    final double neckLeft = (width - neckWidth) / 2;
    final double neckRight = neckLeft + neckWidth;

    // Start at top left of neck
    path.moveTo(neckLeft, 0);

    // Top opening
    path.lineTo(neckRight, 0);

    // Right side of neck
    path.lineTo(neckRight, neckHeight);

    // Right shoulder
    path.quadraticBezierTo(width, neckHeight, width, neckHeight + radius * 1.5);

    // Right straight side
    path.lineTo(width, height - radius);

    // Bottom right corner
    path.quadraticBezierTo(width, height, width - radius, height);

    // Bottom edge
    path.lineTo(radius, height);

    // Bottom left corner
    path.quadraticBezierTo(0, height, 0, height - radius);

    // Left straight side
    path.lineTo(0, neckHeight + radius * 1.5);

    // Left shoulder
    path.quadraticBezierTo(0, neckHeight, neckLeft, neckHeight);

    // Left side of neck
    path.lineTo(neckLeft, 0);

    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
