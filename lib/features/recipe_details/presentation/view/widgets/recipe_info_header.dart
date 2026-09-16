import 'package:cookjar/core/utils/assets/app_icons.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/utils/themes/app_spacing.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:cookjar/features/recipe_details/presentation/view/widgets/recipe_stat_item.dart';
import 'package:flutter/material.dart';

/// Title + rating badge, and the time / servings / calories stat row.
class RecipeInfoHeader extends StatelessWidget {
  const RecipeInfoHeader({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                recipe.name,
                style: AppStyles.bold24,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.lightHoney,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    AppIcons.starRoundedIcon,
                    size: 16,
                    color: AppColors.goldenHoney,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    recipe.rating.toStringAsFixed(1),
                    style: AppStyles.bold14,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            RecipeStatItem(
              icon: AppIcons.timeRoundedIcon,
              label: '${recipe.totalTimeMinutes} min',
            ),
            const SizedBox(width: AppSpacing.lg),
            RecipeStatItem(
              icon: AppIcons.peopleRoundedIcon,
              label: '${recipe.servings}',
            ),
            const SizedBox(width: AppSpacing.lg),
            RecipeStatItem(
              icon: Icons.local_fire_department_rounded,
              label: '${recipe.caloriesPerServing} cal',
            ),
          ],
        ),
      ],
    );
  }
}
