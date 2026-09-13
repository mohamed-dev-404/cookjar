import 'package:cookjar/core/utils/assets/app_images.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12, bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.goldenHoney, AppColors.warmCoral],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Image.asset(AppImages.logo, width: 130),

          const Gap(12),

          Text(
            'CookJar Login',
            style: AppStyles.bold28.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
