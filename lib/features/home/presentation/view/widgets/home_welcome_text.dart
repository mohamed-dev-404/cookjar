import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeWelcomeText extends StatelessWidget {
  const HomeWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Unbox Today\'s Recipe Magic!', style: AppStyles.bold20),
        const Gap(8),
        Text(
          'Shake your jar to pick a delicious surprise.',
          style: AppStyles.regular14,
        ),
      ],
    );
  }
}
