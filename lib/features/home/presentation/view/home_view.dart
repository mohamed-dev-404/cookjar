import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/widgets/buttons/main_button.dart';
import 'package:cookjar/features/home/presentation/view/widgets/home_header.dart';
import 'package:cookjar/features/home/presentation/view/widgets/home_welcome_text.dart';
import 'package:cookjar/features/home/presentation/view/widgets/jar_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCoral,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Greeting & Profile Avatar
            const HomeHeader(),

            const Gap(8),

            // White Main Card Container
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: Column(
                  children: [
                    // Welcoming Title & Subtitle
                    const HomeWelcomeText(),

                    const Spacer(),

                    // Large Jar Container Placeholder
                    const JarPlaceholder(),

                    const Spacer(),

                    // Action Button using Core MainButton
                    MainButton(
                      text: '🎲   Surprise Me!   🎲',
                      onPressed: () {
                        // Action placeholder
                      },
                    ),

                    const Gap(12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
