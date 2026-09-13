import 'package:cookjar/core/routes/routes.dart';
import 'package:cookjar/core/validators/app_validators.dart';
import 'package:cookjar/core/widgets/buttons/main_button.dart';
import 'package:cookjar/core/widgets/inputs/app_text_form_field.dart';
import 'package:cookjar/core/widgets/inputs/password_text_form_field.dart';
import 'package:cookjar/features/auth/presentation/widgets/auth_bottom_text.dart';
import 'package:cookjar/features/auth/presentation/widgets/auth_divider.dart';
import 'package:cookjar/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
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
    return Form(
      key: _formKey,
      child: Column(
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
            validator: AppValidators.validateEmail,
          ),

          const Gap(18),

          // Password
          PasswordTextFormField(
            controller: passwordController,
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            validator: AppValidators.validateNotEmpty,
          ),

          const Gap(35),

          // Login button
          MainButton(
            text: 'Login',
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                // Submit login
              }
            },
          ),

          const Gap(20),

          // Forgot password
          TextButton(
            onPressed: () {
              // Forgot password
            },
            child: Text('Forgot Password?', style: AppStyles.medium16),
          ),

          const Gap(35),

          const AuthDivider(text: 'or login with'),

          const Gap(20),

          const SocialLoginButtons(),

          const Gap(28),

          AuthBottomText(
            promptText: 'New to CookJar? ',
            actionText: 'Create an account.',
            onTap: () {
              context.push(Routes.register);
            },
          ),

          const Gap(10),
        ],
      ),
    );
  }
}
