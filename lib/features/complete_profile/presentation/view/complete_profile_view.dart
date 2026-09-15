import 'package:cookjar/features/complete_profile/presentation/view/widgets/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CompleteProfileView extends StatelessWidget {
  final String name;

  const CompleteProfileView({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(8),

                  const Gap(8),
                  CompleteProfileForm(name: name),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
