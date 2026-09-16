import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:cookjar/features/recipe_details/data/repos/recipe_details_repo.dart';
import 'package:cookjar/features/recipe_details/presentation/view_model/recipe_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  final RecipeDetailsRepo recipeDetailsRepo;

  RecipeDetailsCubit({required this.recipeDetailsRepo})
    : super(const RecipeDetailsInitial());

  void loadRecipeDetails(RecipeModel recipe) {
    emit(RecipeDetailsLoaded(recipe: recipe));
  }

  Future<void> getRecipeDetails({required int recipeId}) async {
    emit(const RecipeDetailsLoading());
    try {
      final recipe = await recipeDetailsRepo.getRecipeDetails(
        recipeId: recipeId,
      );
      emit(RecipeDetailsLoaded(recipe: recipe));
    } on AppException catch (e) {
      emit(RecipeDetailsError(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(RecipeDetailsError(errorMessage: e.toString()));
    }
  }

  /// Local favorite toggle only — wiring this into the actual "saved"
  /// persistence (whatever the Saved feature ends up using) is a follow-up
  /// integration step, not part of this layer.
  void toggleFavorite() {
    final currentState = state;
    if (currentState is RecipeDetailsLoaded) {
      emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
    }
  }
}
