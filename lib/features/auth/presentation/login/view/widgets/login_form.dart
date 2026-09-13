import 'package:cookjar/core/widgets/buttons/main_button.dart';
import 'package:cookjar/core/widgets/inputs/app_text_form_field.dart';
import 'package:cookjar/core/widgets/inputs/password_text_form_field.dart';
import 'package:cookjar/features/auth/presentation/login/view/widgets/auth_bottom_text.dart';
import 'package:cookjar/features/auth/presentation/login/view/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(8),

        Text('Welcome back to CookJar!', style: AppStyles.bold24),

        const Gap(6),

        Text('Shake. Pick. Cook.', style: AppStyles.regular16),

        const Gap(35),

        // Email
        AppTextFormField(
          controller: emailController,
          hintText: 'Username or Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.person_outline),
        ),

        const Gap(18),

        // Password
        PasswordTextFormField(
          controller: passwordController,
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline),
        ),

        const Gap(35),

        // Login button
        MainButton(text: 'Login', onPressed: () {}),

        const Gap(20),

        // Forgot password
        TextButton(
          onPressed: () {
            // Forgot password
          },
          child: Text('Forgot Password?', style: AppStyles.medium16),
        ),

        const Gap(35),

        const _OrLoginWith(),

        const Gap(20),

        const SocialLoginButtons(),

        const Gap(28),

        const AuthBottomText(),

        const Gap(10),
      ],
    );
  }
}

class _OrLoginWith extends StatelessWidget {
  const _OrLoginWith();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.borderGray)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('or login with', style: AppStyles.regular16),
        ),

        Expanded(child: Divider(color: AppColors.borderGray)),
      ],
    );
  }
}
