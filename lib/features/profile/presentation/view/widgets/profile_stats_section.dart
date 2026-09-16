import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/features/profile/presentation/view/widgets/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cookjar/core/di/service_locator.dart';
import 'package:cookjar/core/services/cache/hive/hive_service.dart';

class ProfileStatsSection extends StatelessWidget {
  final String favoriteMeal;
  final int? savedRecipesCount;

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
          ValueListenableBuilder(
            valueListenable: getIt<HiveService>().recipesBox.listenable(),
            builder: (context, box, child) {
              return ProfileInfoCard(
                icon: Icons.access_time_rounded,
                iconColor: AppColors.warmCoral,
                iconBackgroundColor: AppColors.lightCoral,
                cardBackgroundColor: AppColors.warmCoral.withValues(alpha: 0.2),
                title: "Loved Recipes",
                value: "${box.length}",
              );
            },
          ),
        ],
      ),
    );
  }
}
