import 'package:cookjar/core/di/service_locator.dart';
import 'package:cookjar/features/auth/presentation/login/view/login_view.dart';
import 'package:cookjar/features/auth/presentation/login/view_model/login_cubit.dart';
import 'package:cookjar/features/auth/presentation/register/view/register_view.dart';
import 'package:cookjar/features/auth/presentation/register/view_model/register_cubit.dart';
import 'package:cookjar/features/complete_profile/presentation/view/complete_profile_view.dart';
import 'package:cookjar/features/complete_profile/presentation/view_model/complete_profile_cubit.dart';
import 'package:cookjar/features/main/presentation/view/main_view.dart';
import 'package:cookjar/features/recipe_details/presentation/view/recipe_details_view.dart';
import 'package:cookjar/features/recipe_details/presentation/view_model/recipe_details_cubit.dart';
import 'package:cookjar/features/splash/splash.dart';
import 'package:cookjar/features/profile/data/models/profile_model.dart';
import 'package:cookjar/features/profile/presentation/view/edit_profile_view.dart';
import 'package:cookjar/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';
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
        builder: (context, state) {
          final name = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) => getIt<CompleteProfileCubit>(),
            child: CompleteProfileView(name: name),
          );
        },
      ),

      // * Main view
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainAppView(),
      ),

      // * Recipe details view
      // Expects `extra` to be the recipe's model, e.g.:
      //   context.push(Routes.recipeDetails, extra: recipe);
      GoRoute(
        path: Routes.recipeDetails,
        builder: (context, state) {
          final recipe = state.extra;
          if (recipe is! RecipeModel) {
            return const Scaffold(
              body: Center(child: Text('Invalid or missing recipe data')),
            );
          }
          return BlocProvider(
            create: (context) =>
                getIt<RecipeDetailsCubit>()..loadRecipeDetails(recipe),
            child: const RecipeDetailsView(),
          );
        },
      ),

      // * Edit Profile view
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) {
          final profile = state.extra as ProfileModel?;
          if (profile == null) {
            return const Scaffold(
              body: Center(child: Text('Invalid or missing profile data')),
            );
          }
          return BlocProvider(
            create: (context) => getIt<ProfileCubit>()..fetchProfile(),
            child: EditProfileView(profile: profile),
          );
        },
      ),
    ],
  );
}
