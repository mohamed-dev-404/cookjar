import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/features/auth/presentation/login/view/widgets/login_form.dart';
import 'package:cookjar/features/auth/presentation/login/view/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCoral,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LoginHeader(),

              const Gap(16),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: SingleChildScrollView(child: LoginForm()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
