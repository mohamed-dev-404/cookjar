import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

/// Two-column checklist of ingredients. Falls back to a friendly message
/// if the API returns an empty list instead of leaving a blank gap.
class IngredientsList extends StatelessWidget {
  const IngredientsList({super.key, required this.ingredients});

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return Text(
        'No ingredients listed for this recipe.',
        style: AppStyles.regular14.copyWith(
          color: AppColors.darkBrown.withValues(alpha: 0.6),
        ),
      );
    }

    return Wrap(
      runSpacing: 10,
      children: List.generate(ingredients.length, (index) {
        return FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppColors.freshMint,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ingredients[index],
                    style: AppStyles.regular14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
