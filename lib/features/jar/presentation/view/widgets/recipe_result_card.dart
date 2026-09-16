// Renders the selected recipe result inside the CookJar feature.
//
// This widget handles the final visual presentation of the generated recipe.
// It uses [CachedNetworkImage] for network images with clean loading and error
// fallbacks.
//
// When the [recipe] is null (e.g., during the initial animation before the API
// returns), the card displays a skeleton placeholder to maintain visual stability.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';
import 'package:flutter/material.dart';

import '../../../const/jar_constants.dart';

/// A modern recipe card displaying the image and name of the selected recipe.
class RecipeResultCard extends StatelessWidget {
  /// The selected recipe to display, or null if generation is still pending.
  final RecipeModel? recipe;

  /// Whether to layout the text right-to-left.
  final bool isRtl;

  /// Called when the user taps "Cook it now".
  final VoidCallback? onCookNow;

  /// Called when the user taps "Add to favorite".
  final VoidCallback? onAddToFavorite;

  /// Called when the user taps "Re-shake".
  final VoidCallback? onReshake;

  const RecipeResultCard({
    super.key,
    required this.recipe,
    required this.isRtl,
    this.onCookNow,
    this.onAddToFavorite,
    this.onReshake,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: JarConstants.resultCardWidth,
        decoration: BoxDecoration(
          color: JarConstants.resultCardBackground,
          borderRadius: BorderRadius.circular(
            JarConstants.resultCardBorderRadius,
          ),
          boxShadow: const [
            BoxShadow(
              color: JarConstants.dropShadowColor,
              blurRadius: JarConstants.resultCardElevation,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_buildImage(context), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final Widget imageWidget = recipe == null || recipe!.image.isEmpty
        ? _buildPlaceholder()
        : CachedNetworkImage(
            imageUrl: recipe!.image,
            height: JarConstants.resultCardImageHeight,
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildPlaceholder(),
            errorWidget: (context, url, error) => _buildErrorFallback(),
          );

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(JarConstants.resultCardBorderRadius),
      ),
      child: SizedBox(
        height: JarConstants.resultCardImageHeight,
        child: imageWidget,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: JarConstants.resultCardPlaceholderColor,
      height: JarConstants.resultCardImageHeight,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
  }

  Widget _buildErrorFallback() {
    return Container(
      color: JarConstants.resultCardPlaceholderColor,
      height: JarConstants.resultCardImageHeight,
      child: const Center(
        child: Icon(Icons.restaurant, size: 48, color: Colors.grey),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(JarConstants.resultCardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (recipe == null)
            _buildNameSkeleton()
          else
            Text(
              recipe!.name,
              style: const TextStyle(
                fontSize: JarConstants.resultCardNameFontSize,
                fontWeight: FontWeight.bold,
                color: JarConstants.resultCardNameColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: isRtl ? TextAlign.right : TextAlign.left,
            ),
          const SizedBox(height: 24.0),
          if (recipe != null) ...[
            ElevatedButton.icon(
              onPressed: onCookNow,
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Cook it now'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: JarConstants.resultCardNameColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    JarConstants.resultCardBorderRadius,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onAddToFavorite,
                    icon: const Icon(Icons.favorite_border),
                    label: const Text('Favorite'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      foregroundColor: JarConstants.resultCardNameColor,
                      side: const BorderSide(
                        color: JarConstants.resultCardPlaceholderColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          JarConstants.resultCardBorderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReshake,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Re-shake'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      foregroundColor: JarConstants.resultCardNameColor,
                      side: const BorderSide(
                        color: JarConstants.resultCardPlaceholderColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          JarConstants.resultCardBorderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else
            const SizedBox(height: 108.0),
        ],
      ),
    );
  }

  Widget _buildNameSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: JarConstants.resultCardNameFontSize,
          color: JarConstants.resultCardPlaceholderColor,
        ),
        const SizedBox(height: 8.0),
        Container(
          height: JarConstants.resultCardNameFontSize,
          margin: const EdgeInsets.only(right: 48.0),
          color: JarConstants.resultCardPlaceholderColor,
        ),
      ],
    );
  }
}
