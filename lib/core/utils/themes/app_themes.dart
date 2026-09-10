import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get lightTheme => ThemeData(
    //* core theme settings
    scaffoldBackgroundColor: AppColors.backgroundNormal,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      // text color
      onSurface: AppColors.textPrimaryNormal,
    ),

    //* AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      //  surfaceTintColor: Colors.transparent,
    ),

    //* Divider theme
    dividerColor: AppColors.borderNormal,
    dividerTheme: const DividerThemeData(color: AppColors.borderNormal),

    // * TextButton theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(60, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    //* Input decoration theme for styling of text fields
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppStyles.regular14.copyWith(
        color: AppColors.textSecondaryNormal,
      ),
      fillColor: AppColors.backgroundNormal,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderNormal),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorNormal),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorDark),
      ),
    ),

    //* BottomNavigationBar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.borderDarkHover,
      backgroundColor: AppColors.backgroundNormal,
      selectedLabelStyle: AppStyles.medium14.copyWith(
        color: AppColors.textSecondaryNormal,
      ),
      unselectedLabelStyle: AppStyles.medium14.copyWith(
        color: AppColors.textSecondaryNormal,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
  );
}
