import 'package:cookjar/features/saved/data/repositories/saved_repo.dart';
import 'package:cookjar/features/saved/presentation/view_model/saved_recipes_cubit/saved_recipes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedRecipesCubit extends Cubit<SavedRecipesState> {
  SavedRecipesCubit({required this.savedRepo})
    : super(const SavedRecipesInitial());

  final SavedRepo savedRepo;

  Future<void> getSavedRecipes() async {
    emit(const SavedRecipesLoading());

    final result = await savedRepo.getSavedRecipes();

    result.fold(
      (errorMessage) => emit(SavedRecipesFailure(errorMessage: errorMessage)),
      (recipes) => emit(SavedRecipesSuccess(recipes: recipes)),
    );
  }

  Future<void> removeRecipe(int recipeId) async {
    // We don't emit loading state here to keep the list visible in the background
    // If you want to show a loading overlay, you could emit a specific state
    final result = await savedRepo.removeRecipe(recipeId);

    result.fold(
      (errorMessage) => emit(SavedRecipesFailure(errorMessage: errorMessage)),
      (_) {
        // After successful removal, fetch the updated list
        getSavedRecipes();
      },
    );
  }
}
