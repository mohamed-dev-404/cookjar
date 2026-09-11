import 'package:cookjar/core/routes/routes.dart';
import 'package:cookjar/core/utils/assets/app_images.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. Jar shake animation (gradual wobble effect)
    _shakeAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.12), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -0.12, end: 0.12), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 0.12, end: -0.10), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -0.10, end: 0.10), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 0.10, end: -0.05), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -0.05, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.1, 0.7, curve: Curves.easeInOut),
          ),
        );

    // 2. Name fade-in animation right after the shake
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    // Start animation
    _controller.forward();

    // Navigate to the next screen after 3.5 seconds
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        //! Replace with your app's target main/home screen
        context.push(Routes.main);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background frame (bg.png)
          Positioned.fill(child: Image.asset(AppImages.bg, fit: BoxFit.cover)),

          // Main centered content (Jar logo and name)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Jar shake animation wrapper
                AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _shakeAnimation.value,
                      child: child,
                    );
                  },
                  child: Image.asset(AppImages.logo, width: 180),
                ),

                const SizedBox(height: 20),

                // 2. App name fade-in transition
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(AppImages.name, width: 170),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
