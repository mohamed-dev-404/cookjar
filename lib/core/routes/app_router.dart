import 'package:cookjar/core/di/service_locator.dart';
import 'package:cookjar/features/auth/presentation/login/view/login_view.dart';
import 'package:cookjar/features/auth/presentation/login/view_model/login_cubit.dart';
import 'package:cookjar/features/auth/presentation/register/view/register_view.dart';
import 'package:cookjar/features/auth/presentation/register/view_model/register_cubit.dart';
import 'package:cookjar/features/complete_profile/presentation/view/complete_profile_view.dart';
import 'package:cookjar/features/main/presentation/view/main_view.dart';
import 'package:cookjar/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cookjar/core/routes/routes.dart';

class AppRouter {
  AppRouter._();
  static const completeProfile = '/complete-profile';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Routes.main,
    routes: [
      //* Splash view
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashView(),
      ),

      //* Login view
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),

      //* Register view
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        path: Routes.completeProfile,
        builder: (context, state) => const CompleteProfileView(),
      ),

      // * Main view
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainAppView(),
      ),
    ],
  );
}
