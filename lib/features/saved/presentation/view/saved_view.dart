import 'package:flutter/material.dart';
import 'package:cookjar/features/saved/presentation/view/widgets/saved_app_bar.dart';
import 'package:cookjar/features/saved/presentation/view/widgets/saved_recipe_list.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SavedAppBar(numberOfSavedRecipes: 7),
      body: SavedRecipeList(),
    );
  }
}
