import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/utils/themes/app_radius.dart';
import 'package:cookjar/core/utils/themes/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.warmCoral,
        primary: AppColors.warmCoral,
        onPrimary: AppColors.white,
        secondary: AppColors.goldenHoney,
        onSecondary: AppColors.darkBrown,
        tertiary: AppColors.freshMint,
        surface: AppColors.white,
        onSurface: AppColors.darkBrown,
        error: AppColors.error,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
      dividerColor: AppColors.borderGray,
      appBarTheme: CustomAppBarTheme.lightTheme,
      elevatedButtonTheme: CustomButtonTheme.lightElevated,
      outlinedButtonTheme: CustomOutlinedButtonTheme.lightTheme,
      inputDecorationTheme: CustomInputTheme.lightTheme,
      chipTheme: CustomChipTheme.lightTheme,
      cardTheme: CustomCardTheme.lightTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.warmCoral,
        foregroundColor: AppColors.white,
        elevation: 4,
      ),
    );
  }
}

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static AppBarTheme get lightTheme => AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.darkBrown,
    elevation: 0,
    scrolledUnderElevation: 0.5,
    centerTitle: false,
    titleTextStyle: AppStyles.bold20.copyWith(fontSize: 18.0),
    iconTheme: const IconThemeData(color: AppColors.darkBrown),
    actionsIconTheme: const IconThemeData(color: AppColors.darkBrown),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._();

  static OutlinedButtonThemeData get lightTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.warmCoral,
      side: const BorderSide(color: AppColors.warmCoral),
    ),
  );
}

class CustomButtonTheme {
  CustomButtonTheme._();

  static ElevatedButtonThemeData get lightElevated => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.warmCoral,
      foregroundColor: AppColors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderPill),
      textStyle: AppStyles.bold15,
    ),
  );
}

class CustomCardTheme {
  CustomCardTheme._();

  static CardThemeData get lightTheme => const CardThemeData(
    color: AppColors.white,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.borderLg,
      side: BorderSide(color: AppColors.borderGray, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
  );
}

class CustomChipTheme {
  CustomChipTheme._();

  static ChipThemeData get lightTheme => ChipThemeData(
    backgroundColor: AppColors.offWhite,
    disabledColor: AppColors.borderGray,
    selectedColor: AppColors.lightCoral,
    secondarySelectedColor: AppColors.warmCoral,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xxs,
    ),
    labelStyle: AppStyles.medium12.copyWith(fontWeight: FontWeight.w600),
    secondaryLabelStyle: AppStyles.medium12.copyWith(
      color: AppColors.warmCoral,
      fontWeight: FontWeight.w600,
    ),
    brightness: Brightness.light,
    shape: const RoundedRectangleBorder(
      borderRadius: AppRadius.borderPill,
      side: BorderSide(color: AppColors.borderGray),
    ),
  );
}

class CustomInputTheme {
  CustomInputTheme._();

  static InputDecorationTheme get lightTheme => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.offWhite,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),

    // 1. Hint Style (Soft readable dark brown tint)
    hintStyle: AppStyles.regular14.copyWith(
      color: AppColors.darkBrown.withValues(alpha: 0.45),
    ),

    // 2. Label Styles
    labelStyle: AppStyles.medium14.copyWith(
      color: AppColors.darkBrown.withValues(alpha: 0.7),
    ),
    floatingLabelStyle: AppStyles.medium14.copyWith(
      color: AppColors.warmCoral,
      fontWeight: FontWeight.w600,
    ),

    // 3. Icon Colors matching the CookJar dark brown palette
    prefixIconColor: AppColors.darkBrown.withValues(alpha: 0.6),
    suffixIconColor: AppColors.darkBrown.withValues(alpha: 0.6),

    // 4. Default Border
    border: const OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.darkBrown, width: 1.0),
    ),

    // 5. Idle State (Enabled Border)
    enabledBorder: const OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.darkBrown, width: 1.2),
    ),

    // 6. Active State (Focused Border with Warm Coral)
    focusedBorder: const OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.warmCoral, width: 2.0),
    ),

    // 7. Error States
    errorBorder: const OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.error, width: 1.2),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.error, width: 2.0),
    ),
    errorStyle: AppStyles.medium12.copyWith(color: AppColors.error),
  );
}
