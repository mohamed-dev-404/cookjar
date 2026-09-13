import 'package:flutter/material.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';

class AuthBottomText extends StatelessWidget {
  const AuthBottomText({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  final String promptText;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(promptText, style: AppStyles.medium16),
        InkWell(
          onTap: onTap,
          child: Text(actionText, style: AppStyles.bold16),
        ),
      ],
    );
  }
}
