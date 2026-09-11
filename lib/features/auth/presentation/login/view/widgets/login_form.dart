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

  bool obscurePassword = true;

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

        const Text(
          'Welcome back to CookJar!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),

        const Gap(6),

        Text('Shake. Pick. Cook.', style: AppStyles.regular16),

        const Gap(35),

        // Email
        AppTextFormField(
          controller: emailController,
          hintText: 'Username or Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.person_outline, size: 27),
        ),

        const Gap(18),

        // Password
        PasswordTextFormField(
          controller: passwordController,
          hintText: 'Password',
          // obscureText: obscurePassword,
          // textInputAction: TextInputAction.done,
          prefixIcon: const Icon(Icons.lock_outline, size: 25),
          // suffixIcon: IconButton(
          //   onPressed: () {
          //     setState(() {
          //       obscurePassword = !obscurePassword;
          //     });
          //   },
          //   icon: Icon(
          //     obscurePassword
          //         ? Icons.visibility_off_outlined
          //         : Icons.visibility_outlined,
          //   ),
          // ),
        ),

        const Gap(35),

        // Login button
        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              // Login logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warmCoral,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const Gap(20),

        // Forgot password
        TextButton(
          onPressed: () {
            // Forgot password
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
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
        Expanded(child: Divider(color: Colors.grey.shade300)),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('or login with', style: TextStyle(fontSize: 16)),
        ),

        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }
}
