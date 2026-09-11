import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColors.warmCoral,
    this.borderColor,
    this.minWidth = double.infinity,
    this.minHeight = 55,
    this.textColor = AppColors.white,
    this.isLoading = false,
    this.disabledBgColor = AppColors.borderGray,
  });
  final String text;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color disabledBgColor;
  final Color? borderColor;
  final double minWidth;
  final double minHeight;
  final Color textColor;

  /// When true the button shows a spinner and ignores taps.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        disabledBackgroundColor: disabledBgColor,
        padding: EdgeInsets.zero,
        maximumSize: Size(minWidth, minHeight),
        minimumSize: Size(minWidth, minHeight),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: textColor,
              ),
            )
          //todo: text hint style
          : Text(text, style: AppStyles.bold15.copyWith(color: textColor)),
    );
  }
}
