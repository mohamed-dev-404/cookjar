import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

/// One stat chip in the info row — e.g. "35 min", "4", "500 cal".
class RecipeStatItem extends StatelessWidget {
  const RecipeStatItem({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.warmCoral),
        const SizedBox(width: 6),
        Text(label, style: AppStyles.medium14),
      ],
    );
  }
}
