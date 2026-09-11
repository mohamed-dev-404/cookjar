import 'package:cookjar/features/auth/presentation/login/view/widgets/login_form.dart';
import 'package:cookjar/features/auth/presentation/login/view/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDFB),
      body: SafeArea(
        child: Column(
          children: [
            const LoginHeader(),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: const SingleChildScrollView(child: LoginForm()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
