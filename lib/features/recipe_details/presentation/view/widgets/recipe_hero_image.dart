import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Full-bleed hero image at the top of the Recipe Details screen, with a
/// circular back button overlaid in the top-left safe area.
///
/// Handles the two things a network image can do wrong: still loading, or
/// failed to load (bad/expired URL, no connection to the image host even
/// if the API call itself succeeded).
class RecipeHeroImage extends StatelessWidget {
  const RecipeHeroImage({
    super.key,
    required this.imageUrl,
    required this.onBack,
    this.height = 280,
  });

  final String imageUrl;
  final VoidCallback onBack;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: AppColors.lightCoral,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.warmCoral),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.lightCoral,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                    color: AppColors.warmCoral,
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: _CircleIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: onBack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: AppColors.darkBrown),
        ),
      ),
    );
  }
}
