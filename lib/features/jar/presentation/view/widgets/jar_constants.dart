// Defines centralized visual, dimensional, and timing constants for the CookJar feature.
//
// This file exists to avoid magic numbers and scattered literals throughout the jar widgets.
// It provides a single source of truth for the jar's physical dimensions, colors,
// animation timings, and audio asset paths.

import 'package:flutter/material.dart';

class JarConstants {
  // ---------------------------------------------------------------------------
  // Dimensions
  // ---------------------------------------------------------------------------

  /// The default fixed width of the jar.
  static const double jarWidth = 220.0;

  /// The default fixed height of the jar.
  static const double jarHeight = 300.0;

  /// The height of the jar's neck.
  static const double jarNeckHeight = 40.0;

  /// The width of the jar's neck.
  static const double jarNeckWidth = 140.0;

  /// Corner radius for the main jar body.
  static const double jarCornerRadius = 32.0;

  /// Width of the cork lid.
  static const double lidWidth = 130.0;

  /// Height of the cork lid.
  static const double lidHeight = 45.0;

  /// Corner radius for the cork lid.
  static const double lidCornerRadius = 8.0;

  // ---------------------------------------------------------------------------
  // Recipe Result Card
  // ---------------------------------------------------------------------------

  static const double resultCardWidth = 300.0;
  static const double resultCardImageHeight = 200.0;
  static const double resultCardBorderRadius = 16.0;
  static const double resultCardElevation = 12.0;
  static const double resultCardPadding = 16.0;
  static const double resultCardNameFontSize = 20.0;
  static const Color resultCardBackground = Color(0xFFFFFFFF);
  static const Color resultCardNameColor = Color(0xFF1A1A2E);
  static const Color resultCardPlaceholderColor = Color(0xFFE8EDF2);

  // ---------------------------------------------------------------------------
  // Colors
  // ---------------------------------------------------------------------------

  /// Base tint color for the glass.
  static const Color glassColor = Color(0x1A00E5FF); // Very subtle cyan tint

  /// Color for glass highlights to create a 3D effect.
  static const Color glassHighlight = Color(0x66FFFFFF);

  /// Color for glass shadows/rims.
  static const Color glassShadow = Color(0x1A000000);

  /// Base color for the cork lid.
  static const Color corkBaseColor = Color(0xFFD2B48C);

  /// Shadow color for cork texture.
  static const Color corkShadowColor = Color(0xFF8B5A2B);

  /// Base color for the decorative folded papers inside the jar.
  static const Color innerPaperColor = Color(0xFFFDF5E6);

  /// Color for the lines drawn on the decorative folded papers.
  static const Color innerPaperLineColor = Color(0x22000000);

  /// Generic drop shadow color.
  static const Color dropShadowColor = Color(0x33000000);

  // ---------------------------------------------------------------------------
  // Animation Durations
  // The complete opening sequence takes approximately 5.4 seconds.
  // Timeline: shake(3s) → lid(0.6s) → paper(1s) → quote(0.8s)
  // The closing sequence takes approximately 1.1 seconds.
  // ---------------------------------------------------------------------------

  /// Duration for the jar shaking phase. Matches shaking_jar.mp3 (~3 seconds).
  static const Duration shakeDuration = Duration(milliseconds: 3000);

  /// Duration for the cork lid to open upward. Matches open_cork_jar_top.mp3 (~0.6s).
  static const Duration lidOpenDuration = Duration(milliseconds: 600);

  /// Duration for the paper to emerge, rise, rotate, and unfold.
  /// Matches crumpling_paper.mp3 (~1 second).
  static const Duration paperRevealDuration = Duration(milliseconds: 1000);

  /// Duration for the quote text to fade in after the paper settles.
  static const Duration quoteRevealDuration = Duration(milliseconds: 800);

  /// Duration for the quote text to fade out when closing.
  static const Duration quoteCloseDuration = Duration(milliseconds: 250);

  /// Duration for the paper to contract and return to the jar when closing.
  static const Duration paperCloseDuration = Duration(milliseconds: 500);

  /// Duration for the cork lid to return to its resting position when closing.
  static const Duration lidCloseDuration = Duration(milliseconds: 350);

  // ---------------------------------------------------------------------------
  // Shake Animation Values
  // ---------------------------------------------------------------------------

  /// Number of full back-and-forth swings during the shake phase.
  static const int shakeOscillations = 18;

  /// Maximum horizontal displacement in pixels during the shake.
  static const double shakeAmplitude = 22.0;

  /// Maximum rotational displacement in radians during the shake (~7 degrees).
  static const double shakeRotationAmplitude = 0.12;

  // ---------------------------------------------------------------------------
  // Inner Paper Movement (during shake)
  // ---------------------------------------------------------------------------

  /// Maximum additional horizontal shift for decorative papers during shake.
  /// Each paper derives its own amplitude from this base using a deterministic factor.
  static const double innerPaperShakeAmplitude = 12.0;

  /// Maximum additional rotation for decorative papers during shake (radians).
  static const double innerPaperShakeRotation = 0.18;

  // ---------------------------------------------------------------------------
  // Lid Opening Animation Values
  // ---------------------------------------------------------------------------

  /// How far the lid moves upward when opening (pixels).
  static const double lidOpenTranslationY = -80.0;

  /// Slight rotation as the cork pops off (radians, ~6 degrees).
  static const double lidOpenRotation = -0.10;

  // ---------------------------------------------------------------------------
  // Paper Reveal Animation Values
  // ---------------------------------------------------------------------------

  /// Starting Y-offset of the paper relative to its final center position.
  /// Positive means below the center (emerging from inside the jar).
  static const double paperStartOffsetY = 250.0;

  /// Initial scale of the paper when it first emerges (compact/crumpled look).
  static const double paperStartScale = 0.3;

  /// Maximum rotation of the paper during emergence (radians, ~8 degrees).
  static const double paperRevealRotation = 0.14;

  // ---------------------------------------------------------------------------
  // Quote Reveal Animation Values
  // ---------------------------------------------------------------------------

  /// Initial scale of the quote text when the reveal begins.
  static const double quoteRevealStartScale = 0.92;

  /// Initial upward offset of the quote text (pixels) — subtle slide-up.
  static const double quoteRevealStartOffsetY = 12.0;

  // ---------------------------------------------------------------------------
  // Audio Playback
  // ---------------------------------------------------------------------------

  /// Global volume for all audio playback (0.0 to 1.0).
  /// Hardcoded to 1.0 to ensure sounds play at their intended natural volume.
  static const double globalAudioVolume = 1.0;

  // ---------------------------------------------------------------------------
  // Audio Asset Paths
  // ---------------------------------------------------------------------------

  static const String shakeAudioAsset = 'audios/shaking_jar.mp3';
  static const String corkAudioAsset = 'audios/open_cork_jar_top.mp3';
  static const String paperAudioAsset = 'audios/crumpling_paper.mp3';
}
