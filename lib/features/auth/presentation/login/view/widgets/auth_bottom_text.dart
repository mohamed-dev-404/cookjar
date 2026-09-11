import 'package:flutter/material.dart';

class AuthBottomText extends StatelessWidget {
  const AuthBottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        const Text('New to CookJar? ', style: TextStyle(fontSize: 16)),
        GestureDetector(
          onTap: () {
            // Navigate to register
          },
          child: const Text(
            'Create an account.',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
