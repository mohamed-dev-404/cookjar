import 'package:flutter/material.dart';
import 'package:cookjar/core/utils/assets/app_icons.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/utils/themes/app_radius.dart';
import 'package:cookjar/core/utils/themes/app_spacing.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';

class SavedRecipeCard extends StatelessWidget {
  const SavedRecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = true,
  });

  final RecipeModel recipe;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.borderLg,
        border: Border.all(
          color: AppColors.warmCoral.withValues(alpha: 0.6),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderLg,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              // 1. Recipe Image
              ClipRRect(
                borderRadius: AppRadius.borderMd,
                child: Image.network(
                  recipe.image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 90,
                    height: 90,
                    color: AppColors.offWhite,
                    child: const Icon(
                      AppIcons.restaurantIcon,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // 2. Recipe Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Recipe Title
                    Text(
                      recipe.name,
                      style: AppStyles.bold16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Cooking Time & Servings
                    Row(
                      children: [
                        Icon(
                          AppIcons.timeRoundedIcon,
                          size: 16,
                          color: AppColors.darkBrown.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.totalTimeMinutes} min',
                          style: AppStyles.medium12.copyWith(
                            color: AppColors.darkBrown.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),

                        Icon(
                          AppIcons.peopleRoundedIcon,
                          size: 16,
                          color: AppColors.darkBrown.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.servings} servings',
                          style: AppStyles.medium12.copyWith(
                            color: AppColors.darkBrown.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Rating
                    Row(
                      children: [
                        const Icon(
                          AppIcons.starRoundedIcon,
                          size: 18,
                          color: AppColors.goldenHoney,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          recipe.rating.toStringAsFixed(1),
                          style: AppStyles.bold14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 3. Favorite Button
              IconButton(
                onPressed: onFavoriteTap,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.warmCoral,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
