import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

/// Placeholder widget for the CookJar bottle.
/// Replace this widget or image container with your actual Jar design asset/vector.
class JarPlaceholder extends StatelessWidget {
  const JarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 290,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Jar Lid (Wooden Cork)
          Positioned(
            top: 0,
            child: Container(
              width: 100,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFC79257),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),

          // Jar Body (Translucent Glass Bottle)
          Positioned(
            top: 26,
            child: Container(
              width: 200,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1).withValues(alpha: 0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                border: Border.all(color: const Color(0xFF80CBC4), width: 3.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF80CBC4).withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glass Reflection Highlight
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 12,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),

                  // Floating Recipe Slips inside the jar
                  Positioned(
                    bottom: 30,
                    left: 30,
                    child: _buildRecipeSlip(angle: -0.2, label: '🍕 Pizza'),
                  ),
                  Positioned(
                    bottom: 45,
                    right: 35,
                    child: _buildRecipeSlip(angle: 0.25, label: '🍝 Pasta'),
                  ),
                  Positioned(
                    bottom: 75,
                    child: _buildRecipeSlip(angle: -0.05, label: '🥗 Salad'),
                  ),
                  Positioned(
                    bottom: 110,
                    left: 45,
                    child: _buildRecipeSlip(angle: 0.15, label: '🍔 Burger'),
                  ),

                  // Center Hint Text
                  Positioned(
                    top: 70,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'CookJar',
                        style: AppStyles.bold16.copyWith(
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeSlip({required double angle, required String label}) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFFFD54F)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: AppStyles.bold12.copyWith(color: AppColors.darkBrown),
        ),
      ),
    );
  }
}
