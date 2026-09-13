import 'package:cookjar/core/common/app_snack_bar.dart';
import 'package:cookjar/core/routes/routes.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/validators/app_validators.dart';
import 'package:cookjar/core/widgets/buttons/main_button.dart';
import 'package:cookjar/core/widgets/inputs/app_text_form_field.dart';
import 'package:cookjar/core/widgets/inputs/password_text_form_field.dart';
import 'package:cookjar/features/auth/presentation/widgets/auth_bottom_text.dart';
import 'package:cookjar/features/auth/presentation/widgets/auth_divider.dart';
import 'package:cookjar/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:cookjar/features/auth/presentation/login/view_model/login_cubit.dart';
import 'package:cookjar/features/auth/presentation/login/view_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() == true) {
      context.read<LoginCubit>().login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          AppSnackBar.success(context, 'Logged in successfully!');
          context.go(Routes.main);
        } else if (state is LoginError) {
          AppSnackBar.error(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

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
                isLoading: isLoading,
                onPressed: _onLoginPressed,
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
      },
    );
  }
}
