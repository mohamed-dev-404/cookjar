import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  AppStyles._();

  //! ───────────────────────── Headings (Poppins) ─────────────────────────

  // --- Size 32 (Heading 1) ---
  static final TextStyle regular32 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium32 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold32 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );

  // --- Size 28 (Heading 2) ---
  static final TextStyle regular28 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium28 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold28 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );

  // --- Size 24 (Heading 3) ---
  static final TextStyle regular24 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium24 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold24 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );

  // --- Size 20 (Heading 4) ---
  static final TextStyle regular20 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium20 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold20 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );

  //! ───────────────────────── Body & Subtitles (Inter) ───────────────────

  // --- Size 16 (Body Large) ---
  static final TextStyle regular16 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium16 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold16 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );

  // --- Size 15 (Button) ---
  static final TextStyle regular15 = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium15 = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold15 = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );

  // --- Size 14 (Body) ---
  static final TextStyle regular14 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium14 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold14 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );

  // --- Size 12 (Caption) ---
  static final TextStyle regular12 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBrown,
  );
  static final TextStyle medium12 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBrown,
  );
  static final TextStyle bold12 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBrown,
  );
}
