import 'package:flutter/material.dart';
import 'package:cookjar/core/routes/routes.dart';
import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';
import 'package:cookjar/features/saved/presentation/view/widgets/saved_recipe_card.dart';
import 'package:go_router/go_router.dart';

class SavedRecipeList extends StatelessWidget {
  const SavedRecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    // Demo recipes list
    final List<RecipeDetailsModel> recipes = [
      const RecipeDetailsModel(
        id: 1,
        name:
            'Classic Margherita Pizza Classic Margherita Pizza Classic Margherita Pizza',
        image: 'https://cdn.dummyjson.com/recipe-images/1.webp',
        rating: 4.5,
        prepTimeMinutes: 10,
        cookTimeMinutes: 20,
        servings: 4,
        caloriesPerServing: 300,
        ingredients: [],
        instructions: [],
      ),
      const RecipeDetailsModel(
        id: 2,
        name: 'Recipe Title 2',
        image: 'https://cdn.dummyjson.com/recipe-images/2.webp',
        rating: 4.8,
        prepTimeMinutes: 15,
        cookTimeMinutes: 30,
        servings: 6,
        caloriesPerServing: 450,
        ingredients: [],
        instructions: [],
      ),
      const RecipeDetailsModel(
        id: 3,
        name: 'Recipe Title 3',
        image: 'https://cdn.dummyjson.com/recipe-images/3.webp',
        rating: 4.2,
        prepTimeMinutes: 10,
        cookTimeMinutes: 10,
        servings: 2,
        caloriesPerServing: 250,
        ingredients: [],
        instructions: [],
      ),
      const RecipeDetailsModel(
        id: 4,
        name: 'Recipe Title 4',
        image: 'https://cdn.dummyjson.com/recipe-images/4.webp',
        rating: 4.2,
        prepTimeMinutes: 10,
        cookTimeMinutes: 10,
        servings: 2,
        caloriesPerServing: 250,
        ingredients: [],
        instructions: [],
      ),
      const RecipeDetailsModel(
        id: 5,
        name: 'Recipe Title 5',
        image: 'https://cdn.dummyjson.com/recipe-images/5.webp',
        rating: 4.2,
        prepTimeMinutes: 10,
        cookTimeMinutes: 10,
        servings: 2,
        caloriesPerServing: 250,
        ingredients: [],
        instructions: [],
      ),
      const RecipeDetailsModel(
        id: 6,
        name: 'Recipe Title 6',
        image: 'https://cdn.dummyjson.com/recipe-images/6.webp',
        rating: 4.2,
        prepTimeMinutes: 10,
        cookTimeMinutes: 10,
        servings: 2,
        caloriesPerServing: 250,
        ingredients: [],
        instructions: [],
      ),
      const RecipeDetailsModel(
        id: 7,
        name: 'Recipe Title 7',
        image: 'https://cdn.dummyjson.com/recipe-images/7.webp',
        rating: 4.2,
        prepTimeMinutes: 10,
        cookTimeMinutes: 10,
        servings: 2,
        caloriesPerServing: 250,
        ingredients: [],
        instructions: [],
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        return SavedRecipeCard(
          recipe: recipe,
          isFavorite: true,
          onTap: () {
            context.push(Routes.recipeDetails, extra: recipe.id);
          },
          onFavoriteTap: () {
            // TODO: favorite logic later
          },
        );
      },
    );
  }
}
