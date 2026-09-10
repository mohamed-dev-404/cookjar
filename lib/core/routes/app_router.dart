import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cookjar/core/routes/routes.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Routes.login,
    routes: [
      //* Splash view
      // GoRoute(
      //   path: Routes.splash,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<SplashCubit>()..getInitData(),
      //     child: const SplashView(),
      //   ),
      // ),

      //* Login view
      // GoRoute(
      //   path: Routes.login,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<LoginCubit>(),
      //     child: const LoginView(),
      //   ),
      // ),

      //* Register view
      // GoRoute(
      //   path: Routes.register,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<RegisterCubit>(),
      //     child: const RegisterView(),
      //   ),
      // ),

      //* Complete profile view
      // GoRoute(
      //   path: Routes.completeProfile,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<CompleteProfileCubit>()..loadLookups(),
      //     child: const CompleteProfileView(),
      //   ),
      // ),

      // * Main view
      // GoRoute(
      //   path: Routes.main,
      //   builder: (context, state) => const MainAppView(),
      // ),

      // * Profile view
      // GoRoute(
      //   path: Routes.profile,
      //   builder: (context, state) => const ProfileView(),
      // ),
    ],
  );
}
