import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cookjar/core/utils/assets/app_lotties.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double lottieHeight;
  final double? lottieWidth;
  final EdgeInsetsGeometry padding;

  const EmptyStateWidget({
    super.key,
    this.title = 'No Data Found',
    this.subtitle = 'There is nothing to show at the moment.',
    this.lottieHeight = 250,
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
            AppLotties.emptyStateJson,
            height: lottieHeight,
            width: lottieWidth,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppStyles.bold24.copyWith(
              color: AppColors.textPrimaryNormal,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: AppStyles.regular14.copyWith(
              color: AppColors.textSecondaryNormal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
