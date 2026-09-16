import 'package:cookjar/core/di/service_locator.dart';
import 'package:cookjar/core/routes/routes.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/widgets/empty_state_widget.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:cookjar/features/saved/presentation/view/widgets/saved_app_bar.dart';
import 'package:cookjar/features/saved/presentation/view/widgets/saved_recipe_card.dart';
import 'package:cookjar/features/saved/presentation/view_model/saved_recipes_cubit/saved_recipes_cubit.dart';
import 'package:cookjar/features/saved/presentation/view_model/saved_recipes_cubit/saved_recipes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SavedRecipesCubit>()..getSavedRecipes(),
      child: BlocBuilder<SavedRecipesCubit, SavedRecipesState>(
        builder: (context, state) {
          final int count = state is SavedRecipesSuccess
              ? state.recipes.length
              : 0;

          return Scaffold(
            appBar: SavedAppBar(numberOfSavedRecipes: count),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SavedRecipesState state) {
    return switch (state) {
      SavedRecipesInitial() || SavedRecipesLoading() => const Center(
        child: CircularProgressIndicator(color: AppColors.warmCoral),
      ),
      SavedRecipesFailure(:final errorMessage) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 56,
                color: AppColors.warmCoral,
              ),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: AppStyles.bold20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage,
                style: AppStyles.regular14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>
                    context.read<SavedRecipesCubit>().getSavedRecipes(),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
      SavedRecipesSuccess(:final List<RecipeModel> recipes)
          when recipes.isEmpty =>
        EmptyStateWidget(),
      SavedRecipesSuccess(:final List<RecipeModel> recipes) => RefreshIndicator(
        onRefresh: () => context.read<SavedRecipesCubit>().getSavedRecipes(),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return SavedRecipeCard(
              recipe: recipe,
              isFavorite: true,
              onTap: () => context.push(Routes.recipeDetails, extra: recipe),
              onFavoriteTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Remove from favorites?'),
                    content: const Text(
                      'Are you sure you want to remove this recipe from your favorites?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          context.read<SavedRecipesCubit>().removeRecipe(
                            recipe.id,
                          );
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    };
  }
}
