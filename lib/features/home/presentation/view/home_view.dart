import 'package:cookjar/core/di/service_locator.dart';
import 'package:cookjar/core/routes/routes.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/features/home/presentation/view/widgets/home_header.dart';
import 'package:cookjar/features/home/presentation/view/widgets/home_welcome_text.dart';
import 'package:cookjar/features/jar/data/repo/recipe_repo.dart';
import 'package:cookjar/features/jar/presentation/view/cook_jar.dart';
import 'package:cookjar/features/saved/presentation/view_model/add_saved_recipe_cubit/add_saved_recipe_cubit.dart';
import 'package:cookjar/features/saved/presentation/view_model/add_saved_recipe_cubit/add_saved_recipe_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final JarController _jarController;

  @override
  void initState() {
    super.initState();
    _jarController = JarController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Scoped to HomeView — AddSavedRecipeCubit lives only while Home is active.
      create: (_) => getIt<AddSavedRecipeCubit>(),
      child: BlocListener<AddSavedRecipeCubit, AddSavedRecipeState>(
        listener: (context, state) {
          if (state is AddSavedRecipeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Recipe saved! ❤️'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is AddSavedRecipeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.warmCoral,
          body: SafeArea(
            child: Column(
              children: [
                // Header: Greeting & Profile Avatar
                const HomeHeader(),

                const Gap(8),

                // White Main Card Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(36),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Welcoming Title & Subtitle
                        const HomeWelcomeText(),

                        Center(
                          child: Expanded(
                            child: Builder(
                              builder: (context) => AnimatedCookJar(
                                recipeRepo: getIt<RecipeRepo>(),
                                isRtl:
                                    Directionality.of(context) ==
                                    TextDirection.rtl,
                                controller: _jarController,
                                onCookNow: (recipe) {
                                  context.push(
                                    Routes.recipeDetails,
                                    extra: recipe,
                                  );
                                },
                                onAddToFavorite: (recipe) {
                                  context.read<AddSavedRecipeCubit>().addRecipe(
                                    recipe,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
