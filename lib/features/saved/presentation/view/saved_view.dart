import 'package:cookjar/features/saved/presentation/view/widgets/saved_recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:cookjar/core/utils/colors/app_colors.dart';
import 'package:cookjar/core/utils/styles/app_styles.dart';
import 'package:cookjar/core/widgets/buttons/main_button.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // Gives extra height for the subtitle
        centerTitle: true,
        elevation: 6,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.goldenHoney,
                AppColors.warmCoral,
              ], // Warm recipe gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_rounded, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  "Saved Recipes",
                  style: AppStyles.bold20.copyWith(color: AppColors.white),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              "7 delicious recipes collected",
              style: AppStyles.medium12.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        child: MainButton(
          text: 'Add',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              builder: (context) {
                return Container(height: 500);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SavedRecipeCard(
              imageUrl: 'https://cdn.dummyjson.com/recipe-images/1.webp',
              title:
                  'Classic Margherita Pizza Classic Margherita Pizza Classic Margherita Pizza',
              cookingTime: '30 min',
              servings: '4 servings',
              rating: 4.5,
            ),

            SizedBox(height: 25),

            SavedRecipeCard(
              imageUrl: 'https://cdn.dummyjson.com/recipe-images/2.webp',
              title: 'Recipe Title 2',
              cookingTime: '45 min',
              servings: '6 servings',
              rating: 4.8,
            ),

            SizedBox(height: 25),

            SavedRecipeCard(
              imageUrl: 'https://cdn.dummyjson.com/recipe-images/3.webp',
              title: 'Recipe Title 3',
              cookingTime: '20 min',
              servings: '2 servings',
              rating: 4.2,
            ),

            SizedBox(height: 25),

            SavedRecipeCard(
              imageUrl: 'https://cdn.dummyjson.com/recipe-images/4.webp',
              title: 'Recipe Title 3',
              cookingTime: '20 min',
              servings: '2 servings',
              rating: 4.2,
            ),
            const SizedBox(height: 32),

            SavedRecipeCard(
              imageUrl: 'https://cdn.dummyjson.com/recipe-images/5.webp',
              title: 'Recipe Title 3',
              cookingTime: '20 min',
              servings: '2 servings',
              rating: 4.2,
            ),
            const SizedBox(height: 32),

            SavedRecipeCard(
              imageUrl: 'https://cdn.dummyjson.com/recipe-images/6.webp',
              title: 'Recipe Title 3',
              cookingTime: '20 min',
              servings: '2 servings',
              rating: 4.2,
            ),
            const SizedBox(height: 32),

            SavedRecipeCard(
              imageUrl: 'https://cdn.dummyjson.com/recipe-images/7.webp',
              title: 'Recipe Title 3',
              cookingTime: '20 min',
              servings: '2 servings',
              rating: 4.2,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
