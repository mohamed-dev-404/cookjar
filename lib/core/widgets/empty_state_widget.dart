import 'package:cookjar/core/utils/assets/app_lotties.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? lottieAsset;
  final double lottieHeight;
  final double? lottieWidth;
  final EdgeInsetsGeometry padding;

  const EmptyStateWidget({
    super.key,
    this.title = 'No Saved Yet',
    this.subtitle = 'Tap the heart icon on any recipe to save it here.',
    this.lottieAsset,
    this.lottieHeight = 300,
    this.lottieWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieAsset ?? AppLotties.cooking,
            height: lottieHeight,
            width: lottieWidth,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppStyles.bold20.copyWith(color: AppColors.warmCoral),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: AppStyles.regular14.copyWith(
              color: AppColors.darkBrown.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
