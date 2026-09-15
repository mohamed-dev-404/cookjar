import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/enums/favorite_meal.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class FavoriteMealGrid extends StatelessWidget {
  const FavoriteMealGrid({
    super.key,
    required this.selectedMeal,
    required this.onSelect,
  });

  final FavoriteMeal? selectedMeal;
  final ValueChanged<FavoriteMeal> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: FavoriteMeal.values.map((meal) {
        final isSelected = meal == selectedMeal;
        return _MealChip(
          label: meal.label,
          isSelected: isSelected,
          onTap: () => onSelect(meal),
        );
      }).toList(),
    );
  }
}

class _MealChip extends StatelessWidget {
  const _MealChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 140,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.warmCoral : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.warmCoral : AppColors.borderGray,
          ),
        ),
        child: Text(
          label,
          style: isSelected
              ? AppStyles.bold16.copyWith(color: AppColors.white)
              : AppStyles.regular16,
        ),
      ),
    );
  }
}
