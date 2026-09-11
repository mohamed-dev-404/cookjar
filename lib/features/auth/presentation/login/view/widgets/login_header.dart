import 'package:cookjar/core/utils/assets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 35, bottom: 45),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFB15B), Color(0xFFFF694D)],
        ),
      ),
      child: Column(
        children: [
          // Logo
    Image.asset(AppImages.logo , width: 150) ,

          const Gap(16),

          const Text(
            'CookJar Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
