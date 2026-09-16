// Renders the realistic cork lid for the jar.
//
// This widget is intentionally separated from the jar body so that it can be
// independently animated (translated, rotated) in later stages of development.
// It uses gradients and shadows to simulate a 3D cork texture.

import 'package:flutter/material.dart';
import 'jar_constants.dart';

class JarLid extends StatelessWidget {
  const JarLid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: JarConstants.lidWidth,
      height: JarConstants.lidHeight,
      decoration: BoxDecoration(
        color: JarConstants.corkBaseColor,
        borderRadius: BorderRadius.circular(JarConstants.lidCornerRadius),
        // Simulate cork texture and 3D lighting with gradients and shadows
        gradient: const RadialGradient(
          center: Alignment(-0.2, -0.5),
          radius: 1.5,
          colors: [
            Color(0xFFE6CBA3), // Lighter cork highlight
            JarConstants.corkBaseColor,
            JarConstants.corkShadowColor, // Darker cork shadow
          ],
          stops: [0.0, 0.6, 1.0],
        ),
        boxShadow: const [
          // Drop shadow cast onto the jar neck
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 6.0,
            offset: Offset(0, 4),
          ),
          // Inner shadow for top rim realism
          BoxShadow(
            color: Color(0x33FFFFFF),
            blurRadius: 2.0,
            offset: Offset(0, -1),
            spreadRadius: -1,
          ),
        ],
      ),
      // Adding a subtle grain effect using repeating linear gradient could be done,
      // but a simple solid textured gradient looks good enough for "realistic impression"
      // without needing asset images.
      child: Stack(
        children: [
          // Subtle horizontal ridges common in corks
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              color: JarConstants.corkShadowColor.withValues(alpha: 0.3),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              color: JarConstants.corkShadowColor.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
