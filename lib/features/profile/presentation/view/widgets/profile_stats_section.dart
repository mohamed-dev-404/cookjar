import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/features/profile/presentation/view/widgets/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileStatsSection extends StatelessWidget {
  final String favoriteMeal;
  final int savedRecipesCount;

  const ProfileStatsSection({
    super.key,
    required this.favoriteMeal,
    required this.savedRecipesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Favorite Meal Card
          ProfileInfoCard(
            icon: Icons.fastfood_rounded,
            iconColor: AppColors.warmCoral,
            iconBackgroundColor: AppColors.lightCoral,
            cardBackgroundColor: Colors.transparent,
            title: "Favorite Meal",
            value: favoriteMeal.isNotEmpty ? favoriteMeal : "Not set",
          ),
          const Gap(16),
          // Loved Recipes Card
          ProfileInfoCard(
            icon: Icons.access_time_rounded,
            iconColor: AppColors.warmCoral,
            iconBackgroundColor: AppColors.lightCoral,
            cardBackgroundColor: AppColors.warmCoral.withValues(alpha: 0.2),
            title: "Loved Recipes",
            value: "$savedRecipesCount",
          ),
        ],
      ),
    );
  }
}
