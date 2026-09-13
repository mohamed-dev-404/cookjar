import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/features/auth/presentation/widgets/auth_header.dart';
import 'package:cookjar/features/auth/presentation/register/view/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCoral,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  AuthHeader(title: 'CookJar Register'),
                  Gap(16),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
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
                child: const RegisterForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
