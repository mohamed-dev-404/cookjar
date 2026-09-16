import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:cookjar/features/saved/data/repos/saved_repo.dart';
import 'package:cookjar/features/saved/presentation/view_model/add_saved_recipe_cubit/add_saved_recipe_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSavedRecipeCubit extends Cubit<AddSavedRecipeState> {
  AddSavedRecipeCubit({required this.savedRepo})
    : super(const AddSavedRecipeInitial());

  final SavedRepo savedRepo;

  Future<void> addRecipe(RecipeModel recipe) async {
    emit(const AddSavedRecipeLoading());

    final result = await savedRepo.saveRecipe(recipe);

    result.fold(
      (errorMessage) => emit(AddSavedRecipeFailure(errorMessage: errorMessage)),
      (_) => emit(const AddSavedRecipeSuccess()),
    );
  }
}
