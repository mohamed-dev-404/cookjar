import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/themes/app_radius.dart';
import 'package:cookjar/core/utils/themes/app_spacing.dart';
import 'package:cookjar/core/widgets/animated_loading_widget.dart';
import 'package:cookjar/core/widgets/empty_state_widget.dart';
import 'package:cookjar/features/recipe_details/presentation/view/widgets/collapsible_section.dart';
import 'package:cookjar/features/recipe_details/presentation/view/widgets/favorite_button.dart';
import 'package:cookjar/features/recipe_details/presentation/view/widgets/ingredients_list.dart';
import 'package:cookjar/features/recipe_details/presentation/view/widgets/instructions_list.dart';
import 'package:cookjar/features/recipe_details/presentation/view/widgets/recipe_hero_image.dart';
import 'package:cookjar/features/recipe_details/presentation/view/widgets/recipe_info_header.dart';
import 'package:cookjar/features/recipe_details/presentation/view_model/recipe_details_cubit.dart';
import 'package:cookjar/features/recipe_details/presentation/view_model/recipe_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailsView extends StatelessWidget {
  const RecipeDetailsView({super.key});

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
        builder: (context, state) {
          return switch (state) {
            RecipeDetailsInitial() || RecipeDetailsLoading() => const Center(
              child: AnimatedLoadingWidget(),
            ),
            RecipeDetailsError(:final errorMessage) => SafeArea(
              child: EmptyStateWidget(
                title: 'Something went wrong',
                subtitle: errorMessage,
              ),
            ),
            RecipeDetailsLoaded(:final recipe, :final isFavorite) => Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecipeHeroImage(
                        imageUrl: recipe.image,
                        onBack: () => _handleBack(context),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -24),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppRadius.xl),
                              topRight: Radius.circular(AppRadius.xl),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RecipeInfoHeader(recipe: recipe),
                              const SizedBox(height: AppSpacing.xl),
                              CollapsibleSection(
                                title: 'Ingredients',
                                child: IngredientsList(
                                  ingredients: recipe.ingredients,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xl),
                              CollapsibleSection(
                                title: 'Instructions',
                                child: InstructionsList(
                                  instructions: recipe.instructions,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: AppSpacing.xl,
                  right: AppSpacing.xl,
                  bottom: AppSpacing.xl,
                  child: FavoriteButton(
                    isFavorite: isFavorite,
                    onPressed: () =>
                        context.read<RecipeDetailsCubit>().toggleFavorite(),
                  ),
                ),
              ],
            ),
          };
        },
      ),
    );
  }
}
