// Renders decorative paper pieces inside the jar.
//
// This widget provides visual depth and realism by filling the jar with
// folded placeholder quotes. It uses fixed positions for deterministic layout.
//
// During the shake phase, an optional [shakeAnimation] drives subtle
// per-paper movement. Each paper derives its own offset/rotation from the
// shared shake progress using deterministic factors — no separate animation
// controllers per paper.

import 'dart:math';
import 'package:flutter/material.dart';
import '../../../const/jar_constants.dart';

/// Holds the deterministic per-paper visual properties, computed once.
class _PaperData {
  final double left;
  final double bottom;
  final double baseRotation;

  /// Deterministic factor (0–1) used to derive this paper's shake response.
  final double shakeFactor;

  /// Deterministic phase offset so papers don't all move in unison.
  final double shakePhase;

  /// Pre-built widget to prevent recreating BoxDecorations on every frame.
  final Widget widget;

  const _PaperData({
    required this.left,
    required this.bottom,
    required this.baseRotation,
    required this.shakeFactor,
    required this.shakePhase,
    required this.widget,
  });
}

class JarContents extends StatefulWidget {
  /// Optional animation that drives the shake progress (0→1).
  /// When null or dismissed, papers sit in their static positions.
  final Animation<double>? shakeAnimation;

  const JarContents({super.key, this.shakeAnimation});

  @override
  State<JarContents> createState() => _JarContentsState();
}

class _JarContentsState extends State<JarContents> {
  /// Pre-computed paper data — generated once, never regenerated on rebuild.
  static final List<_PaperData> _papers = _generatePaperData();

  static List<_PaperData> _generatePaperData() {
    final random = Random(42);
    final List<_PaperData> papers = [];

    for (int i = 0; i < 15; i++) {
      final double w = 40.0 + random.nextDouble() * 20.0;
      final double h = 25.0 + random.nextDouble() * 15.0;
      final double leftOffset = -80.0 + random.nextDouble() * 160.0;
      final double bottomOffset =
          10.0 + (i * 8.0) + (random.nextDouble() * 15.0);
      final double rotation = -0.5 + random.nextDouble();

      papers.add(
        _PaperData(
          left: (JarConstants.jarWidth / 2) + leftOffset - (w / 2),
          bottom: bottomOffset,
          baseRotation: rotation,
          shakeFactor: 0.4 + random.nextDouble() * 0.6, // 0.4–1.0
          shakePhase: random.nextDouble() * pi * 2, // 0–2π
          widget: _PaperChip(width: w, height: h),
        ),
      );
    }

    return papers;
  }

  @override
  Widget build(BuildContext context) {
    final animation = widget.shakeAnimation;

    // When not shaking, render static papers (no AnimatedBuilder overhead).
    if (animation == null) {
      return _buildStaticContents();
    }

    // During shake, AnimatedBuilder drives subtle paper movement.
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => _buildAnimatedContents(animation.value),
    );
  }

  Widget _buildStaticContents() {
    return SizedBox(
      width: JarConstants.jarWidth,
      height: JarConstants.jarHeight,
      child: ClipPath(
        clipper: _JarBodyClipper(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            for (final paper in _papers)
              Positioned(
                bottom: paper.bottom,
                left: paper.left,
                child: Transform.rotate(
                  angle: paper.baseRotation,
                  child: paper.widget,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContents(double progress) {
    return SizedBox(
      width: JarConstants.jarWidth,
      height: JarConstants.jarHeight,
      child: ClipPath(
        clipper: _JarBodyClipper(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            for (final paper in _papers)
              Positioned(
                bottom: paper.bottom,
                left: paper.left + _paperDx(paper, progress),
                child: Transform.rotate(
                  angle: paper.baseRotation + _paperDr(paper, progress),
                  child: paper.widget,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Derive horizontal shift from the shared shake progress.
  double _paperDx(_PaperData paper, double progress) {
    return sin(progress * pi * 8 + paper.shakePhase) *
        JarConstants.innerPaperShakeAmplitude *
        paper.shakeFactor;
  }

  /// Derive rotational shift from the shared shake progress.
  double _paperDr(_PaperData paper, double progress) {
    return sin(progress * pi * 8 + paper.shakePhase + 0.5) *
        JarConstants.innerPaperShakeRotation *
        paper.shakeFactor;
  }
}

/// A single decorative paper chip — extracted to avoid recreating decoration
/// objects inside the animated build loop.
class _PaperChip extends StatelessWidget {
  final double width;
  final double height;

  const _PaperChip({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: JarConstants.innerPaperColor,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 2.0,
            offset: Offset(1, 1),
          ),
        ],
        border: Border.all(color: JarConstants.innerPaperLineColor, width: 0.5),
      ),
    );
  }
}

/// Clips papers to the jar's interior silhouette.
class _JarBodyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;
    final Path path = Path();

    const double neckWidth = JarConstants.jarNeckWidth;
    const double neckHeight = JarConstants.jarNeckHeight;
    const double radius = JarConstants.jarCornerRadius;

    final double neckLeft = (width - neckWidth) / 2;
    final double neckRight = neckLeft + neckWidth;

    path.moveTo(neckLeft, 0);
    path.lineTo(neckRight, 0);
    path.lineTo(neckRight, neckHeight);
    path.quadraticBezierTo(width, neckHeight, width, neckHeight + radius * 1.5);
    path.lineTo(width, height - radius);
    path.quadraticBezierTo(width, height, width - radius, height);
    path.lineTo(radius, height);
    path.quadraticBezierTo(0, height, 0, height - radius);
    path.lineTo(0, neckHeight + radius * 1.5);
    path.quadraticBezierTo(0, neckHeight, neckLeft, neckHeight);
    path.lineTo(neckLeft, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
