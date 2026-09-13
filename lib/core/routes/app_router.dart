import 'package:cookjar/core/di/service_locator.dart';
import 'package:cookjar/features/auth/presentation/login/view/login_view.dart';
import 'package:cookjar/features/auth/presentation/register/view/register_view.dart';
import 'package:cookjar/features/auth/presentation/register/view_model/register_cubit.dart';
import 'package:cookjar/features/main/presentation/view/main_view.dart';
import 'package:cookjar/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cookjar/core/routes/routes.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      //* Splash view
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashView(),
      ),

      //* Login view
      GoRoute(path: Routes.login, builder: (context, state) => const LoginView()),

      //* Register view
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterView(),
        ),
      ),

      // * Main view
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainAppView(),
      ),
    ],
  );
}

