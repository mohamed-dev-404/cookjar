import 'package:flutter/material.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';

class SavedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SavedAppBar({super.key, required this.numberOfSavedRecipes});
  final int numberOfSavedRecipes;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70, // Gives extra height for the subtitle
      centerTitle: true,
      elevation: 6,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.goldenHoney, AppColors.warmCoral],
          ),
        ),
      ),
      title: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                "Saved Recipes",
                style: AppStyles.bold20.copyWith(color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            "$numberOfSavedRecipes delicious recipes collected",
            style: AppStyles.medium12.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
