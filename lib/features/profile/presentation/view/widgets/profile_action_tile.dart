import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color iconColor;
  final Color? backgroundColor;

  const ProfileActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor = AppColors.darkBrown,
    this.iconColor = AppColors.darkBrown,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 26,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.bold16.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
