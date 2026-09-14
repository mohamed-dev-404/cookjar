import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/features/complete_profile/presentation/view/widgets/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(8),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Gap(8),
                  const CompleteProfileForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}