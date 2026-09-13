import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AuthBottomText extends StatelessWidget {
  const AuthBottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text('New to CookJar? ', style: AppStyles.medium16),
        GestureDetector(
          onTap: () {
            // Navigate to register
          },
          child: Text('Create an account.', style: AppStyles.bold16),
        ),
      ],
    );
  }
}
