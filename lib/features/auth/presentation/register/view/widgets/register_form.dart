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
import 'package:cookjar/features/auth/presentation/register/view_model/register_cubit.dart';
import 'package:cookjar/features/auth/presentation/register/view_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState?.validate() == true) {
      context.read<RegisterCubit>().register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
if (state is RegisterSuccess) {
  AppSnackBar.success(context, 'Account created successfully!');
  context.go(Routes.completeProfile);
} else if (state is RegisterError) {
          AppSnackBar.error(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              const Gap(8),

              Text('Create Account', style: AppStyles.bold24),

              const Gap(6),

              Text('Join CookJar today!', style: AppStyles.regular16),

              const Gap(28),

              // Full Name
              AppTextFormField(
                controller: nameController,
                hintText: 'Full Name',
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.person_outline),
                validator: AppValidators.validateName,
              ),

              const Gap(16),

              // Email
              AppTextFormField(
                controller: emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.email_outlined),
                validator: AppValidators.validateEmail,
              ),

              const Gap(16),

              // Password
              PasswordTextFormField(
                controller: passwordController,
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                validator: AppValidators.validatePassword,
              ),

              const Gap(16),

              // Confirm Password
              PasswordTextFormField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock_outline),
                validator: (val) => AppValidators.validateConfirmPassword(
                  val,
                  passwordController.text,
                ),
              ),

              const Gap(28),

              // Register Button
              MainButton(
                text: 'Register',
                isLoading: isLoading,
                onPressed: _onRegisterPressed,
              ),

              const Gap(28),

              const AuthDivider(text: 'or register with'),

              const Gap(20),

              const SocialLoginButtons(),

              const Gap(24),

              AuthBottomText(
                promptText: 'Already have an account? ',
                actionText: 'Log in.',
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    context.pop();
                  } else {
                    context.go(Routes.login);
                  }
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
