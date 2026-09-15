import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/utils/themes/app_radius.dart';
import 'package:flutter/material.dart';

/// The pill-shaped "Add to Favorites" CTA at the bottom of the screen.
/// Switches to a filled state once favorited.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  final bool isFavorite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFavorite ? AppColors.warmCoral : AppColors.white,
          side: const BorderSide(color: AppColors.warmCoral),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderPill),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 20,
              color: isFavorite ? AppColors.white : AppColors.warmCoral,
            ),
            const SizedBox(width: 8),
            Text(
              isFavorite ? 'Added to Favorites' : 'Add to Favorites',
              style: AppStyles.bold15.copyWith(
                color: isFavorite ? AppColors.white : AppColors.warmCoral,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
